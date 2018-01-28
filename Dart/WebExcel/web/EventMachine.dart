import 'Manager.dart';
import 'Cell.dart';

class EventMachine {
  Manager manager = new Manager();

  void handle(String id) {
    Cell activator = manager.at(id);
    activator.parse();
    activator.disconnect();
    activator.compute();
    activator.notifyAll();
  }

  void showRaw(String id) {
    Cell activator = manager.at(id);
    activator.showRaw();
  }
}