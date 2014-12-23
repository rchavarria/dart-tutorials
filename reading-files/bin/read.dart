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

    FileSystemEntity.isDirectory(filePath)
        .then((pathIsDirectory) {
            if (pathIsDirectory) {
                return new Future.error('${filePath} is a directory and can not be read');
            }

            return new Future.value();
        })
        .then((_) => file.exists())
        .then((fileExists) {
            if (!fileExists) {
                return new Future.error('File ${filePath} does not exists');
            }

            return new Future.value(filePath);
        })
        .then((_) {
            print('${filePath} contents:');
            file.openRead()                     // returns a Stream to listen to
                .transform(UTF8.decoder)        // transforms int's to characters
                .transform(new LineSplitter())  // split in lines
                .listen((line) {                // listen each line
                    print(line);
                });
        })
	.catchError((error) => print('ERROR: ${error}'));
}

