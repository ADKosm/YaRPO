import 'dart:collection';
import 'dart:math';
import 'Player.dart';
import 'GameOrder.dart';
import 'GameManager.dart';
import 'Painter.dart';

class GameCore {
  GameManager manager;

  GameCore() {
    manager = new GameManager();
    startNewGame();
  }

  HashMap<Point, Player> field = new HashMap<Point, Player>();
  GameOrder order = new GameOrder();
  Painter painter = new Painter();

  void setPoint(Player player, Point point) {
    if(order.current() != player || field.containsKey(point)) return;

    field[point] = player;

    for(Point<int> delta in [
        new Point<int>(1, 0),
        new Point<int>(1, 1),
        new Point<int>(0, 1),
        new Point<int>(-1, 1)
      ]) {
      int successes = 1;

      for(int i = 1; i <= 5; i++) {
        Point<int> cpoint = point + delta*i;
        if(field[cpoint] == player) {
          successes++;
        } else {
          break;
        }
      }

      for(int i = 1; i <= 5; i++) {
        Point<int> cpoint = point + delta*(-i);
        if(field[cpoint] == player) {
          successes++;
        } else {
          break;
        }
      }

      if(successes >= 5) {
        redraw();
        painter.winner(player);
      }
    }

    order.next();
    redraw();
  }
  void addPlayer(Player player) {
    order.addPlayer(player);
    redraw();
  }
  void removePlayer(Player player) {
    order.removePlayer(player);
    redraw();
  }
  void startNewGame() {
    for(Player p in field.values) p.socket.close();
    field.clear();
    order.clear();
    manager.clear();
  } // TODO: call in constructor

  void redraw() {
    painter.redrawAll(field.values, field, order.current());
  }
}