import 'dart:html';
import 'dart:async';
import 'dart:convert';

class WebSocketClient {
    TextInputElement intervalElement = querySelector('#interval');
    DivElement statusElement = querySelector('#status');
    DivElement messagesElement = querySelector('#messages');
    WebSocket webSocket;

    WebSocketClient() {
        // listen change events on input text interval
        intervalElement.onChange.listen((e) {
            int seconds = int.parse(intervalElement.value,
                                    onError: (_) => setStatus('Error parsing ${intervalElement.value}'));
            getMessagesEvery(seconds);
            intervalElement.value = '';
        });

        // connect to the web socket
        connect();
    }

    void getMessagesEvery(int seconds) {
        if (seconds == null) {
            setStatus('No request will be sent');
            return;
        }

        setStatus('The server will answer every ${seconds} seconds');

        var request = { 'interval': seconds.toString() };
        webSocket.send(JSON.encode(request));
    }

    void connect() {
        // a web socket connection uses the `ws://` protocol
        // to the same host and port as the index.html file is served
        // to the URL intervalMessages
        webSocket = new WebSocket('ws://${Uri.base.host}:${Uri.base.port}/intervalMessages');

        webSocket.onOpen.first.then((_) {
            // send an event the web socket is connected when the channel is opened
            onConnected();
            webSocket.onClose.first.then((_) {
                onDisconnected("Connection to ${webSocket.url} closed");
            });
        });
        webSocket.onError.first.then((_) {
            onDisconnected("Failed to connect to ${webSocket.url}");
        });
    }

    void onConnected() {
        setStatus('');
        intervalElement.disabled = false;
        intervalElement.focus();

        webSocket.onMessage.listen((e) {
            handleMessage(e.data);
        });
    }

    void handleMessage(jsonFormattedData) {
        setStatus('Data received');
    }

    void onDisconnected(String msg) {
        setStatus('Disconnected because of ${msg}');
        intervalElement.disabled = true;
    }

    void setStatus(String status) {
        statusElement.innerHtml = status;
    }
}

void main() {
    var client = new WebSocketClient();
}

