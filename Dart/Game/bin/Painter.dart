import 'dart:collection';
import 'dart:math';
import 'Player.dart';

class Painter {
  final int cellCount = 20; // must equals to same property on client

  void redrawAll(Iterable<Player> players, HashMap<Point, Player> field,
      Player current) {
    for(Player player in players) {
      redrawField(player, field);
      redrawMyName(player);
      redrawCurrentPlayerName(player, current);
    }
  }

  void redrawField(Player player, HashMap<Point, Player> field) {
    //TODO: implement
  }

  void redrawMyName(Player player) {
    //TODO: implement
  }

  void redrawCurrentPlayerName(Player player, Player currentPlayer) {
    //TODO: implement
  }

  void winner(Player player) {
    //TODO: implement
  }
}