import 'dart:async';

void main() {
    // singleStream();
    streamProperties();
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


