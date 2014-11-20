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










[Cómo crear un web component]: ../custom-element-dart-tutorial



