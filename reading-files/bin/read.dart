import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main(List<String> arguments) {
    if (arguments.length != 1) {
        print('Usage: dart bin/read.dart <filename>');
        return;
    }

    String filePath = arguments[0];
    readFile(filePath);
}

void readFile(String filePath) {
    File file = new File(filePath);

    file.exists()
    .then((fileExists) {
        if (!fileExists) {
            return new Future.error('File ${filePath} does not exists');
        }

        return new Future.value(filePath);
    })
    .then((filePath) => FileSystemEntity.isDirectory(filePath))
    .then((pathIsDirectory) {
        if (pathIsDirectory) {
            return new Future.error('File ${filePath} is a directory');
        }

        return new Future.value(filePath);
    })
    .then((filePath) {
        print('Finally, reading file ${filePath}');
        file.openRead()
            .transform(UTF8.decoder)
            .transform(new LineSplitter())
            .listen((line) {
                print(line);
            });
    });
}

