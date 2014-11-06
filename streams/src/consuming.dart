import 'dart:async';

void main() {
    // singleStream();
    // streamProperties();
    // broadcast();
    // subsetsOfStreamData();
    // transformingStream();
    validatingStream();
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

transformingStream() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  
  // define a stream transformer
  var transformer = new StreamTransformer.fromHandlers(handleData: (value, sink) {
    // create two new values from the original value
    sink.add("Message: $value");
    sink.add("Body: $value");
  });
    
  // transform the stream and listen to its output
  stream.transform(transformer).listen((value) => print("listen: $value"));
}

validatingStream() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  var broadcastStream = stream.asBroadcastStream(); 
  
  broadcastStream
      .any((value) => value < 3)
      .then((result) => print("Any less than 3?: $result")); // true
  
  broadcastStream
      .every((value) => value < 5)
      .then((result) => print("All less than 5?: $result")); // false
  
  broadcastStream
      .contains(4)
      .then((result) => print("Contains 4?: $result")); // true
}




