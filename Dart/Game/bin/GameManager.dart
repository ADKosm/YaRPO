import 'dart:collection';
import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'dart:math';
import 'Player.dart';
import 'GameCore.dart';

class GameManager {
  HashMap<WebSocket, Player> players = new HashMap<WebSocket, Player> ();
  HashMap<String, Function> functions = new HashMap<String, Function>();
  GameCore gameCore;

  GameManager() {
    functions["changeName"] = this.changeName;
    functions["removePlayer"] = this.removePlayer;
    functions["changePosition"] = this.changePosition;
    functions["setPoint"] = this.setPoint;
    gameCore = new GameCore(this);
  }

  void addPlayer(WebSocket socket) {
    Player newPlayer = new Player(socket);
    players[socket] = newPlayer;
    gameCore.addPlayer(newPlayer);

    socket.listen((rawData) {
      var data = JSON.decode(rawData);
      Function.apply(functions[data['type']], [players[socket], data['value']]);
    }, onDone: () {
      removePlayer(players[socket], null);
    });
  }

  void changeName(Player player, var param) { // param is {name}
    player.name = param['name'];
    gameCore.redraw();
  }
  void removePlayer(Player player, var param) { // param is null
    gameCore.removePlayer(player);
  }
  void changePosition(Player player, var param) { // param is {dx, dy}
    player.begin = player.begin + new Point<int>(param['dx'], param['dy']);
    gameCore.redraw();
  }
  void setPoint(Player player, var param) { // param is {x, y}
    Point<int> point = new Point(param['x'], param['y']) + player.begin;
    gameCore.setPoint(player, point);
  }

  void clear() {
    players.clear();
  }

}