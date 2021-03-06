# Navegando directorios

Esta aplicación está inspirada en el tutorial de ejemplo de la página de Dart
[sample-dgrep]. Es una aplicación que navega a través de los directorios de
forma recursiva en busca de patrones: o nombres de ficheros con un patrón
dado o buscando un patrón en el contenido de los ficheros que vaya encontrando.

## Uso básico

El comando básico para ejecutar la aplicación es:

    dart bin/navigate.dart <directory path>

Donde `directory path` es la ruta al directorio que queremos procesar.

## Navegar un directorio

En Dart es muy fácil recorrer un directorio mediante el uso del método `list`
de la clase `Directory`.

```
final directory = new Directory(path);
directory.list().listen( (file) {
    print(file.path);
});
```

## Haciendolo recursivamente

Esto no soluciona del todo el problema, debemos hacerlo recursivamente. En otros
lenguajes esto es un poco complicado, ya que hay que utilizar recursividad o
hacerlo mediante bucles. En Dart, es pasar un parámetro al método `list`.
Increíble.

```
...
directory.list(recursive: true).listen(...);
...
```

## Buscando el patrón

Modificamos la aplicación para que necesite un parámetro adicional, el cual va
a representar un patrón a buscar. De esta forma, la nueva forma de uso será:

    dart bin/navigate.dart <directory path> <pattern>

El método `list` lista las entidades del directorio (tantos directorios como
ficheros). Si es un directorio, pasamos al siguiente. Si es un fichero primero
buscamos el patrón en la ruta y si no lo encontramos, buscamos en el contenido
del mismo. Para buscar en el contenido usamos un método de los aprendidos en el
tutorial sobre [leer ficheros].





TODOs:
- Que se pueda buscar el patrón en el nombre del fichero, no en la ruta 



[sample-dgrep]: https://github.com/dart-lang/sample-dgrep
[leer ficheros]: ../reading-files
