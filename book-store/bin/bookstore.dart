import 'dart:io';

final HOST = '127.0.0.1';
final PORT = 8082;

void main() {
  HttpServer.bind(HOST, PORT).then(successfullyBound, onError: printError);
}

void successfullyBound(server) {
  server.listen((HttpRequest request) {
    print('${request.method}: ${request.uri.path}');

    switch (request.method) {
      case 'POST': 
        handlePost(request);
        break;
      case 'OPTIONS': 
        handleOptions(request);
        break;
      default: defaultHandler(request);
    }
  },
  onError: printError);
  print('Listening for POST requests on http://$HOST:$PORT');
}

void handlePost(HttpRequest req) {
  HttpResponse res = req.response;
  
  addCorsHeaders(res);
  
  req.listen((List<int> buffer) {
    res.write('You said: ');
    res.write(new String.fromCharCodes(buffer));
    res.close();
  },
  onError: printError);
}

void addCorsHeaders(HttpResponse res) {
  res.headers.add('Access-Control-Allow-Origin', '*');
  res.headers.add('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.headers.add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
}

void handleOptions(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);

  res.statusCode = HttpStatus.NO_CONTENT;
  res.close();
}

void defaultHandler(HttpRequest req) {
  HttpResponse res = req.response;
  addCorsHeaders(res);

  res.statusCode = HttpStatus.NOT_FOUND;
  res.write('Not found: ${req.method}, ${req.uri.path}');
  res.close();
}

void printError(error) => print(error);

