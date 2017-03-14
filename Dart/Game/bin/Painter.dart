import 'dart:collection';
import 'dart:math';
import 'Player.dart';
import 'Sender.dart';

class Painter {
  final int cellCount = 20; // must equals to same property on client
  Sender sender = new Sender();

  void redrawAll(Set<Player> players, HashMap<Point, Player> field,
      Player current) {
    for(Player player in players) {
      redrawField(player, field);
      redrawMyName(player);
      redrawCurrentPlayerName(player, current);
    }
  }

  void redrawField(Player player, HashMap<Point, Player> field) {
    for(int x = 0; x < cellCount; x++) {
      for(int y = 0; y < cellCount; y++) {
        Point<int> displayPoint = new Point<int>(x, y);
        Point<int> realPoint = player.begin + displayPoint;
        if(field.containsKey(realPoint)) {
          sender.sendMessage(player.socket, 'drawCell', {
            'x': displayPoint.x,
            'y': displayPoint.y,
            'color': field[realPoint].color
          });
        } else {
          sender.sendMessage(player.socket, 'drawCell', {
            'x': displayPoint.x,
            'y': displayPoint.y,
            'color': 'white'
          });
        }
      }
    }
  }

  void redrawMyName(Player player) {
    sender.sendMessage(player.socket, 'drawMyName', {
      'name': player.name,
      'color': player.color
    });
  }

  void redrawCurrentPlayerName(Player player, Player currentPlayer) {
    sender.sendMessage(player.socket, 'drawCurrentPlayer', {
      'name': currentPlayer.name,
      'color': currentPlayer.color
    });
  }

  void winner(Set<Player> players, Player winner) {
    for(Player player in players) {
      sender.sendMessage(player.socket, 'winner', {
        'name': winner.name
      });
    }
  }
}