import 'dart:io';
import 'dart:math';
import 'dart:convert';

class Player {
  WebSocket socket;
  String name;
  Point<int> begin;
  String color;

  Player(WebSocket socket) {
    this.socket = socket;
    this.color = "#" + new Random().nextInt(16777215).toRadixString(16);
    this.begin = new Point<int>(0, 0);
  }
}