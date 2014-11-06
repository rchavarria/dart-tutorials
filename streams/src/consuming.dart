import 'dart:async';

void main() {
    // singleStream();
    // streamProperties();
    // broadcast();
    subsetsOfStreamData();
}

singleStream() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);

  // subscribe to the streams events
  stream.listen((value) {
    print("Received: $value");
  });
}

streamProperties() {
  var stream;

  // first
  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.first.then((value) => print("stream.first: $value"));

  // last
  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.last.then((value) => print("stream.last: $value"));

  // isEmpty
  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.isEmpty.then((value) => print("stream.isEmpty: $value"));

  // length
  stream = new Stream.fromIterable([1,2,3,4,5]);
  stream.length.then((value) => print("stream.length: $value"));
}

broadcast() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  var broadcastStream = stream.asBroadcastStream();

  broadcastStream.listen((value) => print("broadcastStream.listen: $value")); 
  broadcastStream.first.then((value) => print("broadcastStream.first: $value")); 
  broadcastStream.last.then((value) => print("broadcastStream.last: $value")); 
  broadcastStream.isEmpty.then((value) => print("broadcastStream.isEmpty: $value")); 
  broadcastStream.length.then((value) => print("broadcastStream.length: $value")); 
}

subsetsOfStreamData() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  var broadcastStream = stream.asBroadcastStream(); 
  
  broadcastStream
      .where((value) => value % 2 == 0) 
      .listen((value) => print("where: $value")); 
  
  broadcastStream
      .take(3) 
      .listen((value) => print("take: $value")); 
  
  broadcastStream
      .skip(3)  
      .listen((value) => print("skip: $value")); 
  
  broadcastStream
      .takeWhile((value) => value < 3) 
      .listen((value) => print("takeWhile: $value")); 

  broadcastStream
      .skipWhile((value) => value < 3) 
      .listen((value) => print("skipWhile: $value")); 
}

