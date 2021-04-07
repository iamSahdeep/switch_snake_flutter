import 'dart:collection';

class Cell extends LinkedListEntry<Cell> {
  final int row, col;
  CellType cellType = CellType.EMPTY;

  Cell(this.row, this.col);
}

class Snake {
  LinkedList<Cell> snakePartList = LinkedList();
  late Cell head;
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
}

enum CellType { EMPTY, FOOD, SNAKE_NODE }

enum Direction { Up, Down, Right, Left }
