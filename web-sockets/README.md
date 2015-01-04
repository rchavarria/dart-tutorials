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

1. Crear server que sirva ficheros estáticos

2. Responder frente a peticiones a un web socket

## Recursos

- [Web Sockets]
- [Qué son los Web Sockets] 
- Tutorial oficial [Dartiverse search]

TODOS
+ cliente: crear un web socket
+ cliente: connectar con el servidor
+ servidor: crear un web server que sirva los ficheros
+ cliente: enviar el parámetro del intervalo
+ servidor: responder frente a web sockets
+ cliente: manejar los mensajes enviados por el servidor
+ servidor: enviar un mensaje cada x segundos
+ comenzar a describir el cliente
- comenzar a describir el servidor

[Web Sockets]: https://en.wikipedia.org/wiki/WebSocket
[Qué son los Web Sockets]: http://pusher.com/websockets
[Dartiverse search]: https://github.com/dart-lang/sample-dartiverse-search
[Usando Web Sockets en Dart]: https://github.com/rchavarria/dart-tutorials/tree/master/web-sockets
