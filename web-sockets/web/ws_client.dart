import 'dart:html';

class WebSocketClient {
    TextInputElement intervalElement = querySelector('#interval');
    DivElement statusElement = querySelector('#status');
    DivElement messagesElement = querySelector('#messages');

    WebSocketClient() {
        intervalElement.value = 'foo bar';
        statusElement.innerHtml = 'Esto es el status element';
        messagesElement.innerHtml = 'Y esto el messages element';

        intervalElement.onChange.listen((e) {
            int seconds = int.parse(intervalElement.value,
                                    onError: (_) => print('Error parsing ${intervalElement.value}'));
            getMessagesEvery(seconds);
            intervalElement.value = '';
        });
    }

    void getMessagesEvery(int seconds) {
        if (seconds == null) {
            print('No request will be sent');
            return;
        }

        print('The server will answer every ${seconds} seconds');
    }
}


void main() {
    var client = new WebSocketClient();
}

