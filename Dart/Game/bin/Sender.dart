import 'dart:io';
import 'dart:convert';

class Sender {
  void sendMessage(WebSocket socket, String type, var value) {
    socket.add(JSON.encode({
      "type": type,
      "value": value
    }));
  }
}