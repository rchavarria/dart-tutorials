import 'dart:io';
import 'dart:convert';

void main(List<String> arguments) {
    if (arguments.length != 1) {
        print('Usage: dart bin/read.dart <filename>');
        return;
    }

    String filePath = arguments[0];
    print('You are gonna read the file ${filePath}');
}
