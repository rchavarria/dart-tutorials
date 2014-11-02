# Cómo crear un *Web Component* usando Dart y Polymer

En este tutorial describo lo que he aprendido siguiendo el tutorial acerca
de [Cómo crear un Web Component con Dart y Polymer].

## Introducción

El Web Component que voy a crear con este tutorial es un sencillo cronómetro,
con el cual podremos comenzar a contar el tiempo, pausarlo o detenerlo completamente.

Ràpidamente, los pasos que vamos a seguir son:

1. Importar el fichero HTML que contiene la definición del Web Component
2. Usar el Web Component en nuestra propia página web
3. Inicializar Polymer. La librería de Dart que vamos a usar ya proporciona
el mecanismo para hacerlo, no te preocupes

## Ficheros de los que consta el tutorial

- `web/index.html`: es el punto de entrada de la aplicación. Inicializa Polymer,
importa el Web Component y usa el mismo.
- `web/tute_stopwatch.html`: código HTML que define el Web Component.
importa el Web Component y usa el mismo.
- `web/tute_stopwatch.dart`: código Dart que implementa el Web Component.

## Instalando polymer.dart

Para poder usar Polymer, primero es necesario instalarlo como una dependencia del
proyecto. Para ello, modificar el fichero `pubspec.yaml` y añadir el siguiente
contenido: 

``` 
dependencies:
  polymer: ">=0.15.1 <0.16.0"
``` 

Después, ejecutar el comando `pub get`. `pub` es una herramienta que viene con el
SDK de Dart. Dart Editor también puede ejecutar este comando para instalar todas
las dependencias del proyecto.

## Incluir Polymer en la aplicación

Estos son los ficheros a modificar para usar Polymer en la creación del
Web Component:

`web/tute_stopwatch.html`: importar el fichero `packages/polymer/polymer.html`
antes de definir cualquier Web Component en la aplicación:

``` html
<link rel="import" href="packages/polymer/polymer.html">
<polymer-element name="tute-stopwatch">
```

`web/tute_stopwatch.dart`: importar la librería Polymer en el fichero Dart:

``` 
import 'dart:html';
import 'package:polymer/polymer.dart';
// ...
```

## Instanciar un Web Component

En la página web donde se va a usar el Web Component, debemos importar la definición
del mismo, usar un tag con su nombre (como si fuera un componente HTML normal) e
inicializar Polymer. De forma que `web/index.html` quedaría parecido a:

``` html
<!DOCTYPE html>
<html>
  <head>
    <!-- importa la definición del Web Component -->
    <link rel="import" href="tute_stopwatch.html">
  </head>
 
  <body>
    <!-- usa el Web Component -->
    <tute-stopwatch></tute-stopwatch>
    
    <!-- inicializa Polymer -->
    <script type="application/dart">export "package:polymer/init.dart";</script>
  </body>
</html>
```

## Definiendo el Web Component

La definición del mismo está en el fichero `web/tute_stopwatch.html`. Para definirlo
hay que usar el tag `<polymer-element>` y asignar un nombre al Web Component. En
este caso `tute-stopwatch`.

El tag `<polymer-element>` puede tener dos tags hijos: `<template>`, que contiene
el código HTML; y `<script>`, que contiene el código Dart.

``` html
<polymer-element name="tute-stopwatch">
  <template>
    ...
  </template>
  <script type="application/dart" src="tute_stopwatch.dart"></script>
</polymer-element>
```

## Dando comportamiento al Web Component

El comportamiento es implementado en Dart, en el fichero `web/tute_stopwatch.dart`.
En este fichero, se declara una clase que extiende de `PolymerElement` y está 
anotada con `@CustomTag`. El contenido de `@CustomTag` debe coincidir con el
nombre dado en la definición del Web Component.

```
@CustomTag('tute-stopwatch')
class TuteStopwatch extends PolymerElement {
    TuteStopwatch.created() : super.created();
}
```

Para que todo esté correcto, la clase `TuteStopwatch` debe heredar de `PolymerElement` o
implementar las interfaces `Polymer` y `Observable`. Además, debe definir un
constructor *nombrado* que llame a `super.created()`.

## Enlazando datos entre Dart y el HTML

## Creando manejadores de eventos

## Desplegando la aplicación


[Cómo crear un Web Component con Dart y Polymer]: https://www.dartlang.org/docs/tutorials/polymer-intro/


