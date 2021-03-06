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
  <script type="application/dart">export 'package:polymer/init.dart';</script>
</body>
</html>
```

## El primer Web Component: sortable_app

A continuación creamos el primer Web Component que será usado en `index.html`.
Se llamará `sortable_app`, y consta de dos ficheros: uno HTML y otro Dart.

`sortable_app.html` define la parte visual del Web Component. Para que funcione
debemos importar la parte HTML de la librería Polymer y definir un elemento
`polymer-element`, cuyo atributo `name` será el nombre de nuestro Web Component.
`polymer-element` consta de dos elementos básicamente, `template` y `script`.

En `template` escribiremos el código CSS (bajo la etiqueta `style`) y HTML
que conformarán el Web Component. En `script` incluiremos nuestro código Dart.

``` html
<!DOCTYPE html>
<link rel="import" href="packages/polymer/polymer.html">
<polymer-element name="sortable-app">
  <template>
    <style></style>
    <p>This will include the sortable list</p>
  </template>
  <script type="application/dart" src="sortable_app.dart"></script>
</polymer-element>
```

`sortable_app.dart` define el comportamiento del Web Component. Para poder
implementar la lógica del Web Component debemos incluir, cómo no, la librería
Polymer, creamos una clase que herede de `PolymerElement` y la anotaremos
con `@CustomTag` asociándole un nombre que deberá coincidir con el atributo `name`
de la etiqueta `polymer-element` visto anteriormente. Nuestra clase también
deberá tener un *named constructor* llamado `created()`.

Y para terminar, podemos definir variables que van a ser enlazadas con el HTML
mediante la anotación `@observable` y también añadiremos una lista de tareas que
más tarde ordenaremos.

```
import 'package:polymer/polymer.dart';

@CustomTag('sortable-app')
class SortableApp extends PolymerElement {
  @observable bool applyAuthorStyles = true;

  List<String> tasks = const [
    'Import polymer dart library',
    // ...
    'Define a named constructor .created()'
    ];

  SortableApp.created() : super.created();
}
```

## Ejecutar la aplicación

Ya tenemos algo que podemos probar, todavía no hace nada interesante, pero ya
podemos comprobar si nuestro Web Component funciona. Pero antes, debemos añadir
un *transformer* a nuestro proyecto. En el fichero `pubspec.yaml` añadimos las
siguientes líneas:

``` yaml
transformers:
- polymer:
    entry_points:
    - web/index.html
    - web/sortable_app.html
```

Lo cual indica que, a la hora de publicar la aplicación, se va a aplicar el
*transformer* `polymer` los ficheros `index.html` y `sortable_app.html`.

Ahora, simplemente con el comando `pub serve` podremos visitar [http://localhost]
para poder probar nuestra applicación. Si el puerto 80 está ocupado, se puede
indicar uno con `pub serve --port <puerto>`.

## Siguiente Web Component

El siguiente Web Component a implementar se llamará `sortable-list` y será quien
realice la ordenación propiamente dicha.

Pero comencemos poco a poco. Constará también de dos ficheros: uno para la parte
visual y otro para el comportamiento.

`sortable_list.html` es el fichero que contiene la definición gráfica de este nuevo
Web Component. Por ahora, simplemente haremos que muestre una lista con las
etiquetas `ul` y `li`.

``` html
<link rel="import" href="../../packages/polymer/polymer.html">
<polymer-element name="sortable-list">
  <template>
    <ul>
      <li>First li</li>
    </ul>
  </template>

  <script type="application/dart" src="sortable_list.dart"></script>
</polymer-element>
```

Por su parte, `sortable_list.dart` define el comportamiento de este Web
Component. Por ahora será muy sencillo, no añadirá nada. Lo haremos más adelante.

```
import 'package:polymer/polymer.dart';

@CustomTag('sortable-list')
class SortableList extends PolymerElement {

  SortableList .created() : super.created();

}
```

Modificamos `sortable_app.html` para que incluya la definición de `sortable-list`
y usamos el Web Component definido:

``` html
<link rel="import" href="sortable_list.html">
<polymer-element name="sortable-app">
  <template>
    ...
    <sortable-list></sortable-list>
    ...
  </template>
  ...
</polymer-element>
```

## Mostrando una lista de elementos variables

Vamos a necesitar mostrar una lista de elementos. Para ello en `sortable_list.dart`
añadiremos una variable donde almacenar la lista, y la anotaremos con `@observable`.
De esta forma, la lista será *visible* desde HTML.

El código Dart quedaría más o menos así:

```
...
@observable List<String> taskList = ['one', 'two', 'three'];
...
```

Y el código HTML, usa `<template repeat="">` de Polymer para crear una lista
no numerada por cada uno de los elementos de la variable de Dart:

``` html
<template repeat="{{task in taskList}}">
  <li>{{task}}</li>
</template>
```

## Parametrizando los valores de la lista

El código anterior está muy bien, pero estaría mejor tener una lisa de tareas
que fuera configurable, o al menos, que una entidad exterior (como otro
Web Component por ejemplo) pudiera indicar dicha lista.

Para conseguirlo, añadiremos una propiedad `@published` a `sortable_list.dart`.
Desde `sortable_app.dart` y `sortable_app.html` le pasaremos la lista de
elementos deseados.

`sortable_list.dart`:

```
@published List<String> externalData = [];
final List<String> taskList = toObservable([]);
```

Modificamos la línea de `sortable_app.html` donde se crea el Web Component
`sortable-list`:

``` html
<sortable-list externalData="{{taskSortableList}}"></sortable-list>
```

`externalData` es la variable pública de `sortable-list` al cual establecemos
el valor adecuado desde `sortable-app`. El valor elegido es el valor de la 
variable `taskSortableList` en el fichero `sortable_app.dart`:

```
List<String> taskSortableList = const [...]
```

## Ordenar la lista pulsando en un botón

Por fin, llegamos a la parte final del tutorial: ordenar la lista. Para lanzar
la ordenación, crearemos un botón, y al pulsar sobre él, la lista será
ordenada.

Añadimos el botón en `sortable_list.html` estableciendo un manejador del evento
de click que luego implementaremos:

``` html
<button on-click="{{sortTaskList}}">Sort task list</button>
```

Y la implementación de `sortTaskList` en Dart:

```
sortTaskList() {
  taskList.sort();
}
```

[Cómo crear un web component]: ../custom-element-dart-tutorial

