import 'dart:io';
import 'dart:async';

void main() {
  // chain differen futures. when the future A is resolve, if calls
  // the callback A, who returns the value returned by future B (`expensiveB()`)
  // Then, the callback B is chained and called when that future is
  // is resolved, that returns the last future
  expensiveA().then((aValue) => expensiveB()) 
              .then((bValue) => expensiveC()) 
              .then((cValue) => doSomethingWith(cValue));
}

// create three different futures with new Future.value()
Future expensiveA() => new Future.value('from expensiveA');
Future expensiveB() => new Future.value('from expensiveB');
Future expensiveC() => new Future.value('from expensiveC');

doSomethingWith(value) {
  print(value);
}
