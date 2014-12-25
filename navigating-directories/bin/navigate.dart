import 'dart:io';

void main(List<String> arguments) {
    if (arguments.length != 1) {
        print('Usage: dart bin/navigate.dart <directory name>');
        return;
    }

    String filePath = arguments[0];
    readFile(filePath);
}

void navigate(directoryPath) {
    print('Navigating ${directoryPath}');
}



