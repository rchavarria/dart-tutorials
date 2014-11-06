# Streams

Los *Streams* forman una interfaz única para cualquier cosa que necesite enviar
repetidamente una serie de datos, ya sean eventos HTML (escuchar clicks del usuario),
o eventos de entrada/salida en una aplicación de servidor.

Operaciones sobre Streams:

- Consumir: los datos son sacados de un Stream a uno o varios `StreamSubscriber`
- Producir: los datos son introducidos en un Stream desde un `StreamController`

## Consumiendo un Stream

En lugar de introducir datos al Stream a través de un `StreamController`, vamos a
utilizar el constructor `Stream.fromIterable()`.

Típicamente, se usa el método `listen()` para subscribirse a un stream. Este método
es llamado cada vez que se recibe un dato:

```
var data = [1,2,3,4,5];
var stream = new Stream.fromIterable(data);

// subscribe to the streams events
stream.listen((value) {
  print("Received: $value");
});
```

`Stream` también tiene otros métodos: `first`, `last`, `length` y `isEmpty`. Todos
ellos devuelven un `Future`, el cual se completará con el valor apropiado dentro del
stream:

```
streamProperties() {
  var stream;

  // BEGIN(stream_properties)
  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.first.then((value) => print("stream.first: $value"));  // 1

  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.last.then((value) => print("stream.last: $value"));  // 5  

  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.isEmpty.then((value) => print("stream.isEmpty: $value")); // false

  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.length.then((value) => print("stream.length: $value")); // 5
  // END(stream_properties)
}
```

También se pueden tener varios listeners, pero para eso hay que convertir el stream
en un stream de broadcast con `asBroadcastStream()`. Podremos comprobar de qué tipo
es un stream con la propiedad `isBroadcast`.

```
var data = [1,2,3,4,5];
var stream = new Stream.fromIterable(data);
var broadcastStream = stream.asBroadcastStream();

broadcastStream.listen((value) => print("stream.listen: $value")); 
broadcastStream.first.then((value) => print("stream.first: $value"));
//...
```

