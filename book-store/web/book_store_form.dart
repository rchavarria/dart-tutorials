import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';

@CustomTag('book-store-form')
class BookStoreForm extends FormElement with Polymer, Observable {

    HttpRequest request;
    @observable String errorMessage = '';
    @observable String serverResponse = '';
    @observable String title = '';
    @observable String author = '';

    BookStoreForm.created() : super.created() { 
        polymerCreated();
    }

    void submitForm(Event e, var detail, Node target) {
        e.preventDefault(); // Don't do the default submit.
           
        request = new HttpRequest();
        request.onReadyStateChange.listen(onDataReceived);

        // POST the data to the server.
        var url = 'http://127.0.0.1:8082';
        request.open('POST', url);
        request.send(buildDataToBeSent());
    }

    void onDataReceived(_) {
        if (request.readyState != HttpRequest.DONE) {
            return;
        }

        if (request.status == 0) {
            errorMessage = 'Oops. Is the server running?';
            return;
        }

        if (request.status != 200) {
            errorMessage = 'Something bad happened';
            return;
        }

        serverResponse = request.responseText;
    }

    String buildDataToBeSent() {
        return JSON.encode({ 'title': title, 'author': author });
    }
}

