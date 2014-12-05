import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

@CustomTag('book-store-form')
class BookStoreForm extends FormElement with Polymer, Observable {

    @observable String someText = 'Foo bar';

    BookStoreForm.created() : super.created() { 
        polymerCreated();
    }

    void submitForm(Event e, var detail, Node target) {
        e.preventDefault(); // Don't do the default submit.
           
        HttpRequest request = new HttpRequest();

        // POST the data to the server.
        var url = 'http://127.0.0.1:4040';
        request.open('POST', url);
        request.send(buildDataToBeSent());
    }

    String buildDataToBeSent() {
        return JSON.encode({'foo': 'bar'});
    }
}

