import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'GameManager.dart';

void main(List<String> args) {
  GameManager gameManager = new GameManager();

  HttpServer.bind('localhost', 8888).then( (HttpServer server) {
    server.listen( (HttpRequest req) {
      if ('/ws' == req.uri.path) {
        WebSocketTransformer.upgrade(req).then( (WebSocket socket) {
          gameManager.addPlayer(socket);
        });
      }
      else { // static page
        String path;
        if(req.uri.path == '/') path = "../web/index.html";
        else path = "../web" + req.uri.path;

        RegExp extention = new RegExp(r".*\.(.*)$");
        String ext = extention.firstMatch(path).group(1);

        try {
          Uri indexHtml = Platform.script.resolve(path);
          File f = new File.fromUri(indexHtml);

          req.response.headers.contentLength = f.lengthSync();
          if(ext == "html") req.response.headers.contentType = ContentType.HTML;
          else if(ext == "js") req.response.headers.contentType = ContentType.parse("text/javascript");

          f.openRead().pipe(req.response);
        } catch(e) {
          print(e.toString());
        }
      }
    });
  });
}

//
//socket.listen((_){
//print(_.toString());
//}, onDone: (){
//print("Socket was closed");
//});
//socket.add(
//JSON.encode({
//"type": "hello",
//"value" : {
//"x": 1,
//"y": 2
//}
//})
//);