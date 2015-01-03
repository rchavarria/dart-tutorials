# Usando Web Sockets en Dart

En este tutorial veremos cómo usar [Web Sockets] en una aplicación web escrita
en Dart. Actualmente, las aplicaciones web están siendo más y más complejas. Y
no solamente eso, sino que en muchas ocasiones se necesita la misma aplicación
para distintas plataformas (móvil, web, escritorio,...). 

Los mecanismos de comunicación existentes hasta hace poco tenían ciertos problemas
en este entorno: comunicación en tiempo real, largas conexiones,... Los Web
Sockets solucionan algunos de estos problemas. Éstos proporcionan una comunicación
duradera bidireccional entre un cliente y un servidor sobre una sola conexión
TCP. Lo cual significa que podemos mantener conectados un cliente y un servidor
durante mucho tiempo y que la información puede viajar tanto de cliente al servidor
como del servidor al cliente. Algunas utilizades de los Web Sockets podría ser
una aplicación de video conferencia, o un cliente que pide al servidor una
tarea que le va a llevar mucho tiempo pero quiere recibir resultados intermedios.

Este tutorial está inspirado en el tutorial de ejemplo de la página oficial de
Dart [Dartiverse search]. Nosotros implementaremos algo mucho más sencillo pero
que nos servirá para ilustrar la funcionalidad de los Web Sockets. Crearemos una
aplicación web donde el cliente indicará al servidor un intervalo de tiempo y
el servidor enviará varias respuestas separadas entre sí dicho intervalo.

## Cliente

1. Crear el web socket

2. connectar con el servidor

## Servidor

1. Crear server que sirva ficheros estáticos

2. Responder frente a peticiones a un web socket

## Recursos

- [Web Sockets]
- [Qué son los Web Sockets] 
- Tutorial oficial [Dartiverse search]

TODOS
- comenzar a describir el cliente
- comenzar a descirbir el servidor
+ cliente: crear un web socket
+ cliente: connectar con el servidor
+ servidor: crear un web server que sirva los ficheros
+ cliente: enviar el parámetro del intervalo
- servidor: responder frente a web sockets
- cliente: manejar los mensajes enviados por el servidor

[Web Sockets]: https://en.wikipedia.org/wiki/WebSocket
[Qué son los Web Sockets]: http://pusher.com/websockets
[Dartiverse search]: https://github.com/dart-lang/sample-dartiverse-search

