import 'dart:collection';
import 'Cell.dart';

class Manager {
  static final Manager _singleton = new Manager._internal();
  factory Manager() {
    return _singleton;
  }
  Manager._internal();

  HashMap<String, Cell> cells = new HashMap<String, Cell>();

  void addCell(Cell c) {
    cells[c.id] = c;
  }

  Cell at(String id) {
    return cells[id];
  }

  bool exist(String id) {
    return cells.containsKey(id);
  }

}