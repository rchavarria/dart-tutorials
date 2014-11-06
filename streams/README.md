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
```

`Stream` también tiene otros métodos: `first`, `last`, `length` y `isEmpty`. Todos
ellos devuelven un `Future`, el cual se completará con el valor apropiado dentro del
stream:

```
```

