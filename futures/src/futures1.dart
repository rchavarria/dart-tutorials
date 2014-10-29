import 'dart:io';

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  // read the file synchronously, without Futures
  // it can take really long, and the single thread will freeze until 
  // the file is completely read and printed
  print(file.readAsStringSync());
}

void main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
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
