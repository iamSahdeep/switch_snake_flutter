import 'dart:collection';

import 'Cell.dart';
import 'Cell.dart';
import 'Cell.dart';

class Snake {
  LinkedList<Cell> snakePartList = LinkedList();
  Cell head;
  static const int MAX = 15;

  Snake(Cell initPos) {
    head = initPos;
    snakePartList.add(head);
    snakePartList.add(Cell(0, 0));
    head.cellType = (CellType.SNAKE_NODE);
  }

  void grow(Cell d) {
    snakePartList.add(d);
  }

  void move(Cell nextCell) {
    snakePartList.remove(snakePartList.last);
    snakePartList.last.cellType = (CellType.EMPTY);

    head = nextCell;
    head.cellType = (CellType.SNAKE_NODE);
    snakePartList.addFirst(head);
  }

  bool checkCrash(Cell nextCell) {
    if (snakePartList.contains(nextCell)) return true;
    return false;
  }

  LinkedList<Cell> getSnakePartList() {
    return snakePartList;
  }

  void setSnakePartList(LinkedList<Cell> snakePartList) {
    this.snakePartList = snakePartList;
  }

  Cell getHead() {
    return head;
  }

  void setHead(Cell head) {
    this.head = head;
  }
}
