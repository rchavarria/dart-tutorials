# Librería

En este proyecto vamos a crear una aplicación cliente-servidor para simular
una librería. El cliente tomará unos datos del usuario, como el título del
libro y el autor y los mandará al servidor. Éste, tomará nota y devolverá
una lista de los libros disponibles. Nada nuevo bajo el sol, pero estará
implementado en Dart, tanto la parte del cliente como la del servidor.

## De qué partes consta el proyecto

El flujo del proyecto será el siguiente:

1. Arrancaremos el servidor, escuchando en un puerto, por ejemplo el 4040
2. El usuario introducirá datos en el formulario HTTP
3. El cliente enviará una petición OPTIONS para pedir permiso para poder
enviar la petición POST con los datos
4. El servidor, usando cabeceras [CORS] dará permiso al cliente para
enviar peticiones
5. El cliente formatea los datos en JSON y los envía al servidor
6. El servidor toma los datos enviados, los procesa y envía una
respuesta
7. El cliente procesa la respuesta 

Cliente:

- Enviar los datos de un formulario HTTP programáticamente
- Resetear los datos de un formulario
- Usar Polymer para enlazar los datos de un formulario con variables Dart

Servidor:

- Cabeceras [CORS]
- Manejar peticiones OPTIONS
- Manejar peticiones POST

## Arrancando el servidor

Todavía no hemos desarrollado el servidor, pero cuando lo hagamos, podremos
arrancarlo con un simple comando:

```
dart bin/bookstore-server.dart
```

## Enviando los datos del formulario

El formulario va a enviar los datos al servidor de forma programática, es decir,
vamos a programar qué datos va a enviar y cómo lo va a hacer (método GET o POST
de HTTP). Para ello, el botón *submit* del formulario tendrá un manejador
de evento que le proporcionaremos y desde ahí controlaremos la llamada al
servidor. Este manejador de evento será un método Dart de un Web Component
asociado al formulario.

El código del formulario es muy sencillo, podría ser algo así:

``` html
<form is="book-store-form"></form>
```

De este código cabe destacar el atributo `is` de la etiqueta `form`. Este atributo
indica el Web Component que va a proporcionar comportamiento al formulario. Será
el propio Web Component quien defina los campos del formulario, ya que va a ser
él quien los gestione.

Para definir ese Web Component, crearemos una clase Dart con el siguiente
código:

```
import ...

@CustomTag('book-store-form')
class BookStoreForm extends FormElement with Polymer, Observable {
    // ...

    BookStoreForm.created() : super.created() { 
        polymerCreated();
    }
}

```

El siguiente código corresponde al manejador del evento *click* del botón de
*submit* del formulario. En él, anulamos el comportamiento por defecto del
evento, ya que si no el formulario se enviaría sin nuestro control. También
creamos un objeto `HttpRequest` para enviar los datos al servidor, abrimos
una conexión a través del método POST de HTTP y enviamos los datos en formato
JSON. Más adelante ya veremos cómo podemos escuchar la respuesta del servidor.

```
void submitForm(Event e, var detail, Node target) {
    e.preventDefault();
       
    HttpRequest request = new HttpRequest();

    // POST the data to the server.
    var url = 'http://127.0.0.1:4040';
    request.open('POST', url);
    request.send(buildDataToBeSent());
}
```

## Escuchando datos del servidor

Lo primero que debemos hacer para recibir datos del servidor es escuchar cambios
en `ready state`. Modificamos el método `submitForm` visto anteriormente:

```
//...
request = new HttpRequest();
request.onReadyStateChange.listen(onDataReceived);

var url = 'http://127.0.0.1:4040';
//...
```

Donde `onDataReceived` es el nombre del método que va a escuchar esos cambios.
La implementación de este método es la que sigue:

```
void onDataReceived(_) {
    if (request.readyState != HttpRequest.DONE) {
        return;
    }

    if (request.status != 200) {
        errorMessage = 'Something bad happened';
        return;
    }

    serverResponse = request.responseText;
}
```

En el método se comprueba si la request ha terminado. Si todavía no ha terminado
no hacemos nada. Luego, commprobamos que el código devuelto por el servidor es
`200` (todo correcto). Si no es así, establecemos un valor a una variable
`@observable` para que refleje el error en la vista (HTML). 

Finalmente, si todo es correcto, mostramos la respuesta proporcionada por el
servidor a través de otra propiedad `@observable`.

## Creando el servidor

Crear un servidor en Dart es extremadamente sencillo, simplemente hay que
utilizar la clase `HttpServer`:

```
HttpServer.bind('127.0.0.1', 80).then(successfullyBound, onError: printError);
``` 

Donde `successfullyBound` es un método de callback que será llamado si se
arrancó correctamente el servidor HTTP en la dirección y puerto indicados.

Por ahora, no vamos a implementar respuestas para ninguna petición, simplemente
crearemos un manejador de peticiones por defecto:

```
void successfullyBound(server) {
    server.listen((HttpRequest request) {
        switch (request.method) {
            default:
                defaultHandler(request);
        }
    },
    onError: printError);
    
    print('Listening for HTTP requests on http://127.0.0.1:80');
}

void defaultHandler(HttpRequest req) {
  HttpResponse res = req.response;
  res.statusCode = HttpStatus.NOT_FOUND;
  res.write('Not found: ${req.method}, ${req.uri.path}');
  res.close();
}
```

## Manejar peticiones POST

Por el momento, solo atenderemos peticiones POST, para simplificar el código del
tutorial. La respuesta a una petición POST será simplemente un pequeño texto y
los datos que se envíen desde el formulario.

Adicionalemente, se añadirán unas cabeceras [CORS] para permitir peticiones de
distintos dominios (una petición desde la aplicación cliente esta en un
dominio diferente al de la aplicación servidor en este tutorial).

```
void handlePost(HttpRequest req) {
  HttpResponse res = req.response;
  print('${req.method}: ${req.uri.path}');
  
  addCorsHeaders(res);
  
  req.listen((List<int> buffer) {
    res.write('You said:');
    res.write(new String.fromCharCodes(buffer));
    res.close();
  },
  onError: printError);
}
```

Se recomienda echar un vistazo al método `addCorsHeaders` para ver las cabeceras
CORS que se añaden a la respuesta.

## Manejando peticiones OPTIONS

Cuando un cliente se está ejecutando desde un lugar diferente a la aplicación
servidor, antes de enviar una petición POST, el cliente debe enviar una petición
OPTIONS. 

En la parte del cliente, no debemos hacer nada, ya que la clase `HttpRequest` se
encarga de ello.

En la parte del servidor, debemos manejar estas peticiones. La respuesta para este
tipo de peticiones es sencilla: añadiremos las cabeceras CORS indicando que la
petición es correcta, y devolveremos un código HTTP de que *no ha contenido*. El
código Dart que maneja este tipo de peticiones se encuentra en el método
`handleOptions` del fichero `bin/bookstore.dart`.

Después, el cliente enviará por fin la petición POST.

