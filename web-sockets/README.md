# Usando Web Sockets en Dart

En este tutorial veremos cómo usar [Web Sockets] en una aplicación web escrita
en Dart. Actualmente, las aplicaciones web están siendo más y más complejas. Y
no solamente eso, sino que en muchas ocasiones se necesita la misma aplicación
para distintas plataformas (móvil, web, escritorio,...). 

Los mecanismos de comunicación existentes hasta hace poco tenían ciertos problemas
en este entorno: comunicación en tiempo real, largas conexiones,... Los Web
Sockets solucionan algunos de estos problemas. Éstos proporcionan una comunicación
duradera bidireccional entre un cliente y un servidor sobre una sola conexión
TCP. Lo cual significa que podemos mantener conectados un cliente y un servidor
durante mucho tiempo y que la información puede viajar tanto de cliente al servidor
como del servidor al cliente. Algunas utilizades de los Web Sockets podría ser
una aplicación de video conferencia, o un cliente que pide al servidor una
tarea que le va a llevar mucho tiempo pero quiere recibir resultados intermedios.

Este tutorial está inspirado en el tutorial de ejemplo de la página oficial de
Dart [Dartiverse search]. Nosotros implementaremos algo mucho más sencillo pero
que nos servirá para ilustrar la funcionalidad de los Web Sockets. Crearemos una
aplicación web donde el cliente indicará al servidor un intervalo de tiempo y
el servidor enviará varias respuestas separadas entre sí dicho intervalo.
El código lo puedes encontrar en mi repositorio de Github
[Usando Web Sockets en Dart].

## Cliente

La aplicación es una aplicación web, por lo que la parte cliente de la misma está
compuesta por una página HTML y un script Dart.

La parte HTML es muy simple, lo más importante son dos elementos:

1. Una caja de texto, donde el usuario introducirá el intervalo en segundos
con los que el servidor mandará sus mensajes
2. Un bloque `div` donde vamos a añadir cada uno de los mensajes que envíe el
servidor

El script es algo más complejo, pero no mucho, ¿eh?. Básicamente, consta de dos
partes:

**Responder cuando el usuario introduce un valor**

Añadiremos un manejador de evento a la caja de texto, de forma que cada vez
que el usuario cambie su valor, enviaremos este valor al servidor. Primero,
obtenemos una referencia al elemento, añadimos el manejador de evento, y
establecemos la lógica a realizar cada vez que se lanza el evento. Para enviar
datos al servidor a través del Web Socket utilizaremos el método `send()`
de un objeto `WebSocket`. Se ha decidido enviar los datos en formato JSON,
ya que es un formato muy usado en aplicaciones web.

```
TextInputElement intervalElement = querySelector('#interval');

// listen change events on input text interval
intervalElement.onChange.listen((_) {
    int seconds = int.parse(intervalElement.value);
    if (seconds == null) return; // user didn't enter a number

    var request = { 'interval': seconds.toString() };
    // we're assuming web socket has been initialized before
    webSocket.send(JSON.encode(request));
});
```

**Conectar con el servidor mediante un Web Socket**

La otra parte esencial del cliente es conectar con el servidor a través de un
Web Socket. La conexión no puede ser más sencilla. Simplemente hay que crear
un objeto de la clase `WebSocket` con una URL. El protocolo de dichar URL es
*ws* en lugar de *http* e indicamos que queremos apuntar a `intervalMessages`.
El servidor dedicará esa dirección a gestionar conexiones a través de Web
Sockets.

En nuestro caso, la URL de conexión tendrá esta forma:
`ws://localhost:9223/intervalMessages`.

```
// create web socket through a URL
webSocket = new WebSocket('ws://${Uri.base.host}:${Uri.base.port}/intervalMessages');

// listen when the web socket is opened
webSocket.onOpen.first.then((_) {
    // once the web socket is opened, listen every message sent by the server
    webSocket.onMessage.listen((e) {
        handleMessage(e.data);
    });

    // notify when the web socket is closed properly
    webSocket.onClose.first.then((_) {
        onDisconnected("Connection to ${webSocket.url} closed");
    });
});

// manage cocnnection errors
webSocket.onError.first.then((_) {
    onDisconnected("Failed to connect to ${webSocket.url}");
});

// how to handle every message received from server
void handleMessage(data) {
    // decode json data and select the message property
    var jsonResponse = JSON.decode(data);
    String msg = jsonResponse['message'];

    // append a div element for every message got from server
    var div = new DivElement();
    div.innerHtml = msg;
    // messagesElement is a div element where all messages are appended
    messagesElement.children.add(div);
}
```

## Servidor

En el lado servidor podemos decir que hay tres actividades básicas:

**Servir ficheros estáticos**

Arrancaremos nuestro servidor como una aplicación Dart de consola, la cual escuchará
peticiones HTTP en un puerto de nuestra elección. 

Esta parte de la aplicación se encargará de servir ficheros estáticos, básicamente
los ficheros que forman parte de la parte cliente de este tutorial.

Esto lo implementaremos fácilmente con el paquete
[http_server](http://www.dartdocs.org/documentation/http_server/0.9.5+1/index.html#http_server)
el cual proporciona una clase, `VirtualDirectory`, que hará este trabajo. El código
quedaría más o menos así (ver el 
[código final](https://github.com/rchavarria/dart-tutorials/tree/master/web-sockets)
para comprobar como queda integrado con el resto de partes):

```
import 'package:http_server/http_server.dart' as http_server;
//...
var buildPath = Platform.script.resolve('../build/web').toFilePath();
//...
var virDir = new http_server.VirtualDirectory(buildPath);
virDir.jailRoot = false;
virDir.allowDirectoryListing = false;
```

**Crear conexiones a Web Sockets**

Utilizaremos el paquete
[route](http://www.dartdocs.org/documentation/route/0.4.6/index.html#route)
para responder a conexiones que usen Web Sockets, a través de la clase `Router`
que nos proporciona métodos apropiados para ello.

`Router` puede servir una URL específica, transformar la petición a un objeto
`WebSocket`, con lo que podemos enviar mensajes de vuelta al cliente a través
de ese objeto.

```
import 'package:route/server.dart' show Router;
//...
var router = new Router(server);
router.serve('/intervalMessages')
    .transform(new WebSocketTransformer())
    .listen(handleWebSocket);
```

**Responder a mensajes recibidos a través del Web Socket**

Y por último, el objetivo de este tutorial, reponder a peticiones o a mensajes
recibidos a través de un Web Socket.

Por cada petición HTTP sobre la URL `/intervalMessages`, la clase `Router`
crea un objeto `WebSocket` sobre el que podemos actuar. Lo que hacemos en 
decodificar los mensajes recibidos (son mensajes en formato JSON) y 
procesarlos.

En cada uno de estos mensajes, viene un intervalo en segundos que debemos
esperar entre mensaje y mensaje de respuesta. Lo que hacemos es enviar
10 mensajes iterando en un bucle. Nada especial aquí, construimos un
mensaje, lo codificamos en JSON y lo enviamos de vuelta al cliente mediante
el método `add` de `WebSocket`.

```
// constant to loop
List<int> TIMES = new List<int>.generate(10, (i) => i);

void handleWebSocket(WebSocket webSocket) {
    webSocket
        .map((string) => JSON.decode(string))
        .listen((json) {
            // get interval from data sent by client
            String strInterval = json['interval'];
            int interval = int.parse(strInterval);
            Duration durationInterval = new Duration(seconds: interval);

            // loop 10 times
            TIMES.forEach((i) {
                var response = { 'message': 'Generando mensaje ${i}' };
                webSocket.add(JSON.encode(response));
                // rude way to separate messages, sorry 
                sleep(durationInterval);
            });
        }, onError: (error) {
            // error handling
        });
}
```

## Recursos

- [Usando Web Sockets en Dart]
- [Web Sockets]
- [Qué son los Web Sockets] 
- Tutorial oficial [Dartiverse search]

[Web Sockets]: https://en.wikipedia.org/wiki/WebSocket
[Qué son los Web Sockets]: http://pusher.com/websockets
[Dartiverse search]: https://github.com/dart-lang/sample-dartiverse-search
[Usando Web Sockets en Dart]: https://github.com/rchavarria/dart-tutorials/tree/master/web-sockets
