import 'dart:async';

void main() {
    singleStream();
}

singleStream() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);

  // subscribe to the streams events
  stream.listen((value) {
    print("Received: $value");
  });
}
