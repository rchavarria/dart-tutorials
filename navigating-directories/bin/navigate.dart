import 'dart:io';
import 'dart:async';

void main(List<String> arguments) {
    if (arguments.length != 1) {
        print('Usage: dart bin/navigate.dart <directory name>');
        return;
    }

    String filePath = arguments[0];
    navigate(filePath);
}

void navigate(directoryPath) {
    print('Navigating directory ${directoryPath}');

    FileSystemEntity.isDirectory(directoryPath)
    .then((isDirectory) {
        if (!isDirectory) {
            return new Future.error('${directoryPath} is not a directory');
        }

        final directory = new Directory(directoryPath);
        directory.list(recursive: true).listen( (file) {
            print(file.path);
        });
    })
    .catchError(print);
}



