import 'dart:collection';

class Cell extends LinkedListEntry<Cell>{
  final int row, col;
  CellType cellType = CellType.EMPTY;

  Cell(this.row, this.col);
}

enum CellType {
  EMPTY,
  FOOD,
  SNAKE_NODE
}