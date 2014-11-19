# Tutorial: Sortable List

Este tutorial ha sido inspirado en un tutorial sobre Polymer en la página de 
Dart, *searchable list*. Algunos recursos del mismo son:

- [Enunciado del tutorial](https://www.dartlang.org/samples/searchable_list/)
(guardado en `Downloads`)
- [Código del tuto](https://github.com/dart-lang/sample-searchable-list)
(en ~/repos/dart-tutorials-sample-master/sample-searchable-list)

## Qué vamos a construir

Básicamente, vamos a construir algo similar, pero en lugar de ser una lista donde
buscar por un texto que escribimos, tendremos una lista que podremos ordenar y un
botón que indicará la dirección de ordenación (ascendente o descendente).

Esta aplicación será un aplicación escrita en Dart y mediante Web Components, los
cuales serán implementados por la librería Polymer.

## Punto de entrada a la aplicación

El punto de entrada a la aplicación será el fichero `web/index.html`. Tal como vimos
en el tutorial sobre [Cómo crear un web component], en este fichero importaremos la
definición de nuestros web components, incluiremos la librería Polymer y la
inicializaremos.

``` html
<!DOCTYPE html>
<html>
<head>
  <link rel="import" href="sortable_app.html">
  <title>Sortable list</title>
</head>
<body>
  <sortable-app></sortable-app>
  <script type="application/dart">export 'package:polymer/init.dart';</script>
</body>
</html>
```


[Cómo crear un web component]: ../custom-element-dart-tutorial



