# Leyendo ficheros

En este tutorial veremos cómo leer ficheros con [Dart]. Está basado en
el tutorial [sample-dcat] de la página oficial de Dart.

Para ello usaremos el API de acceso a disco que proporciona el lenguaje,
que está basado en [Futures y llamadas asíncronas] que ya vimos en
un tutorial anterior.

## Uso básico

El comando básico de la aplicación que desarrollaremos es:

    dart bin/read.dart <file>

Donde `file` es la ruta al fichero a leer. El programa mostrará un mensaje de
error en caso de que `file` no exista o sea un directorio.

## Leer de un fichero

Como ocurre siempre en el desarrollo de aplicaciones, existen varias formas
de hacer una misma cosa. En Dart, para leer un fichero, existen varias opciones.
Básicamente, hay dos formas muy comunes de leer ficheros en Dart, tal y como
se describe en la documentación oficial de la clase [dart:io.File]:

1. Mediante métodos de la clase `File`, como `readAsLines`
2. Mediante `Streams`, abriendo un fichero para lectura con `openRead`

El primer método es muy simple, creamos un objeto de la clase `File` y 
llamamos al método `readAsLines`. Este método devuelve un `Future`, así
que para procesar las líneas, debemos hacerlo a través del método `then`
de dicho Future:

```
File f = new File('some file.txt');
f.readAsLines().then((lines) {
    for (var i = 0; i < lines.length; i++) {
        print(lines[i]);
    }
});
```

El segundo, es un método más elaborado. Al hacer uso de `Streams`, podemos utilizar
transformers, y así transformar los contenidos de un fichero a UTF-8 o aplicar
otros transformadores que nosotros implementemos. Este método además, permite leer
ficheros mucho más grandes sin hacer un uso tan intensivo de memoria como hace el
método anterior. Veamos cómo sería leer un fichero con este método:

```
final file = new File('some file.txt');
Stream<List<int>> inputStream = file.openRead();

inputStream
    .transform(UTF8.decoder)       // Decode bytes to UTF8.
    .transform(new LineSplitter()) // Convert stream to individual lines.
    .listen((String line) {        // Process results.
        print(line');
      },
      onError: (e) { print(e.toString()); }
    );
```

Este método utiliza dos transformadores, uno para decodificar el contenido
del fichero a UTF-8 y el otro para convertir el contenido en líneas. Finalmente,
al método `listen` se le pasa un argumento adicional, para controlar los
posibles errores.

## Comprobando errores

El paquete `io` proporciona una clase estática, `FileSystemEntity`, con una
serie de método muy útiles para comprobar ciertas cosas del sistema de
ficheros. Las que nos interesan a nosotros son `exists` e `isDirectory`.

Con estos métodos conoceremos si podemos leer del fichero que el usuario
nos pase por parámetro o no.

```
String path = 'path to some exisiting or not file';
new File(path).exists().then((fileExists) {
    if (!fileExists) {
        print('Error: file ${path} does not exists');
    }
});

FileSystemEntity.isDirectory(path).then((pathIsDirectory) {
    if (pathIsDirectory) {
        print('Error: file ${path} is a directory instead0);
    }
});

```

## Ejecutar la aplicación

`dart bin/read.dart bin` da un error al leer de un directorio
`dart bin/read.dart foobar` da un error a intentar leer un dichero que no existe
`dart bin/read.dart README.md` muestra este fichero por consola


TODOs:
+ investigar cómo crear un Future para poder encadenarlos.
    -> con el constructor Future.value() puedo devolver un Future que me dejará
        encadenar llamadas
+ investigar cómo provocar el fallo en un Future para saltar el flujo de ejecución
    -> con el constructor Future.error() puedo resolver un Future con error
+ crear estructura de ficheros para poder hacer varias pruebas
+ implementar el código
- manejar los errores en un catchError()
- explicar mejor los tres casos de uso
- 

- [Dart]: http://dartlang.org
- [Futures y llamadas asíncronas]: ../futures
- [sample-cat]: https://github.com/dart-lang/sample-dcat/
- [dart:io.File]: https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart:io.File



 
