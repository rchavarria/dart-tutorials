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
```

De este código cabe destacar el atributo `is` de la etiqueta `form`. Este atributo
indica el Web Component que va a proporcionar comportamiento al formulario.

Para definir ese Web Component, crearemos una clase Dart con el siguiente
código:

```
```

El siguiente código corresponde al manejador del evento *click* del botón de
*submit* del formulario. En él, anulamos el comportamiento por defecto del
evento, ya que si no el formulario se enviaría sin nuestro control. También
creamos un objeto `HttpRequest` para enviar los datos al servidor, abrimos
una conexión a través del método POST de HTTP y enviamos los datos en formato
JSON. Más adelante ya veremos cómo podemos escuchar la respuesta del servidor.

```
```


 




TASKS:
- crear el html que contenga el formulario
- crear el web component que va a ser el formulario (va a extender el elemento FORM de html)
- crear campos en el formulario para enviar titulo y autor al servidor
- crear en .dart el método que va a enviar el formulario
- comenzar con el servidor
