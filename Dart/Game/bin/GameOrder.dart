import 'Player.dart';

class GameOrder {
  OrderUnit root = null;

  Player current() {
    return root.player;
  }
  void next() {
    root = root.next;
  }

  void addPlayer(Player player) {
    if(root == null) {
      root = new OrderUnit(player);
      root.next = root;
      root.previous = root;
    } else {
      OrderUnit newUnit = new OrderUnit.withNeighbours(player, root.previous, root);
      root.previous.next = newUnit;
      root.previous = newUnit;
    }
  }
  void removePlayer(Player player) {
    if(root.player == player) {
      root.previous.next = root.next;
      root.next.previous = root.previous;
      root = root.next;
    } else {
      for(OrderUnit current = root.next;; current = current.next) {
        if(current == root) break;
        if(current.player == player) {
          current.previous.next = current.next;
          current.next.previous = current.previous;
          break;
        }
      }
    }
  }

  void clear() {
    root = null;
  }
}

class OrderUnit {
  OrderUnit next;
  OrderUnit previous;
  Player player;

  OrderUnit(Player player) {
    this.player = player;
  }

  OrderUnit.withNeighbours(Player player, OrderUnit prev, OrderUnit next) {
    this.player = player;
    this.previous = prev;
    this.next = next;
  }
}