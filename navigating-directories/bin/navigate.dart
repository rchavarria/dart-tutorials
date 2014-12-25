import 'dart:io';
import 'dart:async';

void main(List<String> arguments) {
    if (arguments.length != 2) {
        print('Usage: dart bin/navigate.dart <directory name> <pattern>');
        return;
    }

    String filePath = arguments[0];
    String pattern = arguments[1];
    navigate(filePath, pattern);
}

void navigate(directoryPath, pattern) {
    print('Navigating directory ${directoryPath} searching for pattern ${pattern}');

    FileSystemEntity.isDirectory(directoryPath)
    .then((isDirectory) {
        if (!isDirectory) {
            return new Future.error('${directoryPath} is not a directory');
        }

        final directory = new Directory(directoryPath);
        directory.list(recursive: true).listen((entity) {
            // skip directories
            if (entity is Directory) {
                return;
            }

            searchPatternInPath(file, pattern);
            searchPatternInContent(file, pattern);
        });
    })
    .catchError(print);
}

void searchPatternInPath(file, pattern) {
    if (file.path.contains(pattern)) {
        print('File ${entity.path} contains the pattern');
    }
}

void searchPatternInContent(file, pattern) {
    file.readAsLines().then((lines) {
        lines.forEach((line) {
            if (line.contains(pattern)) {
                print('File ${file.path} contains the pattern in its content');
            }
        });
    });
}

