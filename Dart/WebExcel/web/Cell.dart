import 'dart:html';
import 'dart:collection';
import 'Manager.dart';
import 'dart:math';

class Cell {
  String id;
  String value;
  String rawValue;
  List<String> plan = new List<String>();
  Set<Cell> speakers = new Set<Cell>(); // speaks to me
  Set<Cell> listeners = new Set<Cell>(); // listen to me

  Cell(String i) {
    this.id = i;
    value = "";
    rawValue = "";
    querySelector("#"+id).text = value;
  }

  void parse() {
    String text = querySelector("#" + id).text;
    rawValue = text;

    if(text.isEmpty || text[0] != "=") {
      plan.add(text);
    } else {
      RegExp pattern = new RegExp(r"(ABS|SIN|LEN|\(|\)|\+|-|\*|/|[0-9\.]+|[a-zA-Z0-9]+)\s*");
      List<String> lexems = new List<String>();

      for(Match m in pattern.allMatches(text.substring(1))) {
        lexems.add(m.group(1));
      }

      ShuntingYard parser = new ShuntingYard(lexems);
      try {
        plan = parser.run();
      } catch(e) {
        window.alert(e.toString());
        querySelector("#"+id).text = "#####";
      }
    }
  }

  void disconnect() {
    for(Cell c in speakers) {
      c.listeners.remove(this);
    }
    speakers.clear();
  }

  void compute() {
    if(rawValue.isEmpty || rawValue[0] != "=") {
      value = rawValue;
      querySelector("#"+id).text = value;
    } else {
      Computator computator = new Computator(this);
      try{
        value = computator.run();
        querySelector("#"+id).text = value;
      } catch (e) {
        window.alert(e.toString());
        querySelector("#"+id).text = "#####";
      }
    }
  }

  void showRaw() {
    querySelector("#" + id).text = rawValue;
  }

  void notifyAll() {
    for(Cell c in listeners) {
      c.compute();
      c.notifyAll();
    }
  }
}

class Computator {
  Manager manager = new Manager();
  Cell cell;
  Queue<String> computationMachine = new Queue<String>();

  RegExp number = new RegExp(r"^[0-9\.]+$");
  RegExp opOrFunc = new RegExp(r"^(ABS|SIN|LEN|\+|-|\*|/)$");

  Computator(this.cell);

  String run() {
    for(String op in cell.plan) {

      if(number.hasMatch(op)) { // number
        computationMachine.addLast(op);
      } else { // not a number
        if(opOrFunc.hasMatch(op)) {
          switch(op) {
            case '+': add(); break;
            case '-': substract(); break;
            case '*': multiply(); break;
            case '/': divide(); break;
            case 'ABS': abs(); break;
            case 'SIN': _sin(); break;
            case 'LEN': len(); break;
          }
        } else { // if just a text
          if(manager.exist(op)) { // if it is a cell
            Cell c = manager.at(op);
            if(c.rawValue.isEmpty) c.parse();
            c.disconnect();
            c.compute();
            c.listeners.add(cell);
            cell.speakers.add(c);
            computationMachine.addLast(c.value);
          } else {
            computationMachine.addLast(op);
          }
        }
      }

    }
    if(computationMachine.isEmpty) {
      window.alert("Computation error");
      throw new Exception("Computation error");
    } else {
      return computationMachine.removeLast();
    }
  }

  void add() {
    num rvalue = num.parse(computationMachine.removeLast());
    num lvalue = num.parse(computationMachine.removeLast()); // TODO: add handling errors
    computationMachine.addLast((rvalue+lvalue).toString());
  }

  void substract() {
    num rvalue = num.parse(computationMachine.removeLast());
    num lvalue = num.parse(computationMachine.removeLast()); // TODO: add handling errors
    computationMachine.addLast((lvalue-rvalue).toString());
  }

  void multiply() {
    num rvalue = num.parse(computationMachine.removeLast());
    num lvalue = num.parse(computationMachine.removeLast()); // TODO: add handling errors
    computationMachine.addLast((lvalue*rvalue).toString());
  }

  void divide() {
    num rvalue = num.parse(computationMachine.removeLast());
    num lvalue = num.parse(computationMachine.removeLast()); // TODO: add handling errors
    computationMachine.addLast((lvalue/rvalue).toString());
  }

  void abs() {
    num rvalue = num.parse(computationMachine.removeLast());
    computationMachine.addLast((rvalue > 0 ? rvalue : rvalue*(-1)).toString());
  }

  void _sin() {
    num rvalue = num.parse(computationMachine.removeLast());
    computationMachine.addLast((sin(rvalue)).toString());
  }

  void len() {
    String rvalue = computationMachine.removeLast();
    computationMachine.addLast(rvalue.length.toString());
  }
}

class ShuntingYard {
  List<String> plan = new List<String>();
  List<String> lexems;

  HashMap<String, num> priority = new HashMap<String, num>();
  Queue<String> operations = new Queue<String>();

  ShuntingYard(List<String> l) {
    lexems = l;

    priority["("] = 0;
    priority[")"] = 0;
    priority["+"] = 1;
    priority["-"] = 1;
    priority["*"] = 2;
    priority["/"] = 2;
    priority["ABS"] = 3;
    priority["SIN"] = 3;
    priority["LEN"] = 3;
  }

  List<String> run() {
    for(String lex in lexems) {
      if(priority.containsKey(lex)) {
        if(lex == "(") {
          operations.addLast(lex);
          continue;
        }
        if(lex == ")") {
          while (operations.last != "(") {
            plan.add(operations.removeLast());
          }
          operations.removeLast();
          continue;
        }
        if(lex == "ABS" || lex == "SIN" || lex == "LEN") {
          operations.addLast(lex);
          continue;
        }
        // if real operator
        while(operations.isNotEmpty && priority[lex] <= priority[operations.last]) {
          plan.add(operations.removeLast());
        }
        operations.addLast(lex);
      } else {
        plan.add(lex); // значение
      }
    }
    while(operations.isNotEmpty) {
      plan.add(operations.removeLast());
    }
    return plan;
  }

}