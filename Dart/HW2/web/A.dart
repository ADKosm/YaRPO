import 'dart:html';

class A {
  int c;
  A(int b ) {
    c = b;
  }

  void print() {
    querySelector('#output').text = c.toString();
  }
}