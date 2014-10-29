import 'dart:io';
import 'dart:async';

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  Future future = file.readAsString();
  // call doSomethingWith content if the file is read
  future.then((content) => doSomethingWith(content))
	// handleError if something was wrong
        .catchError((e) => handleError(e));
  // notice that calls are chained with only one `.`
  // if two dots were used, `..`, the catchError method
  // will be of the future object, and with one `.` the
  // catchError method is of the Future object return by
  // the `then()` method
}

void main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

doSomethingWith(content) {
  print('do something with content');
}

handleError(e) {
  print('handleError');
}

printWinningLotteryNumbers() {
  print('Winning lotto numbers: [23, 63, 87, 26, 2]');
}

printWeatherForecast() {
  print('Tomorrow\'s forecast: 70F, sunny.');
}

printBaseballScore() {
  print('Baseball score: Red Sox 10, Yankees 0');
}
