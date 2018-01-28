// Copyright (c) 2017, alex. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'Manager.dart';
import 'Cell.dart';
import 'EventMachine.dart';

void init() { // initialize table
  Manager manager = new Manager();
  EventMachine eventMachine = new EventMachine();

  TableElement xls = querySelector("#xls");
  TableRowElement thead = xls.tHead.insertRow(-1);
  Element th = new Element.tag("th");
  th.text = "#";
  thead.children.add(th);
  for(int j = 'A'.codeUnitAt(0); j < 'Z'.codeUnitAt(0); j++) {
    Element th = new Element.tag("th");
    th.text = new String.fromCharCode(j);
    thead.children.add(th);
  }
  for(int i = 0; i < 20; i++) {
    TableRowElement row = xls.addRow();
    Element th = new Element.tag("th");
    th.text = i.toString();
    row.children.add(th);
    for(int j = 'A'.codeUnitAt(0); j < 'Z'.codeUnitAt(0); j++) {
      TableCellElement cell = row.addCell();
      cell.setAttribute("contenteditable", "true");
      cell.id = new String.fromCharCode(j) + i.toString();
        cell.onKeyDown.listen((KeyboardEvent e) {
          if(e.keyCode == 13) { // enter
            e.preventDefault();
            eventMachine.handle(cell.id);
            window.getSelection().removeAllRanges();
          }
        });
        cell.onClick.listen((MouseEvent e){
          eventMachine.showRaw(cell.id);
        });
      Cell realCell = new Cell(cell.id);
      manager.addCell(realCell);
    }
  }
}

void main() {
  init();
}
