import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http_server/http_server.dart' as http_server;
import 'package:route/server.dart' show Router;

List<int> TIMES = new List<int>.generate(10, (i) => i);

void handleWebSocket(WebSocket webSocket) {
    webSocket
        .map((string) => JSON.decode(string))
        .listen((json) {
            String strInterval = json['interval'];
            int interval = int.parse(strInterval);
            Duration durationInterval = new Duration(seconds: interval);
            print('Messages will be sent every ${interval} seconds');

            TIMES.forEach((i) {
                webSocket.add('Message ${i}');
                sleep(durationInterval);
            });
        }, onError: (error) {
            print('Error in Web Socket');
            print(error);
        });
}

void main() {
    int port = 9223;
    var buildPath = Platform.script.resolve('../build/web').toFilePath();
    print('build path: ${buildPath}');

    HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, port).then((server) {
        print('Server is running on [http://${server.address.address}:$port/]');

        var router = new Router(server);
        router.serve('/intervalMessages')
            .transform(new WebSocketTransformer())
            .listen(handleWebSocket);

        // Set up default handler. This will serve files from our 'build' directory.
        var virDir = new http_server.VirtualDirectory(buildPath);
        // Disable jail root, as packages are local symlinks.
        virDir.jailRoot = false;
        virDir.allowDirectoryListing = false;

        virDir.serve(router.defaultStream);

        // Add an error page handler.
        virDir.errorPageHandler = (HttpRequest request) {
            request.response.statusCode = HttpStatus.NOT_FOUND;
            request.response.close();
        };
    });
}

