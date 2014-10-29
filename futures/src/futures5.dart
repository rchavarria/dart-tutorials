import 'dart:io';
import 'dart:async';

void main() {
  // the `wait()` method returns a Future that is resolved to a List of
  // values. Each value is the resolved value of each Future passed as 
  // argument. Then, the `wait()` method can be chained with `then()`
  // to handle the List of values returned
  Future.wait([expensiveA(), expensiveB(), expensiveC()])
        .then((List responses) => chooseBestResponse(responses))
        .catchError((e) => handleError(e));
}

Future expensiveA() => new Future.value('from expensiveA');
Future expensiveB() => new Future.value('from expensiveB');
Future expensiveC() => new Future.value('from expensiveC');

doSomethingWith(value) {
  print(value);
}

chooseBestResponse(List responses) {
  print(responses[1]);
}

handleError(e) {
  print('error handled');
}
