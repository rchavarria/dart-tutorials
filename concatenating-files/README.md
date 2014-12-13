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

## 



- [Dart]: http://dartlang.org
- [Futures y llamadas asíncronas]: ../futures
- [sample-cat]: https://github.com/dart-lang/sample-dcat/

