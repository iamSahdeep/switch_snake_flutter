import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:switch_snake/Snake.dart';
import 'dart:math' as Math;
import 'Cell.dart';
import 'Cell.dart';
import 'Cell.dart';

enum Direction { Up, Down, Right, Left }

class GameNotifier extends ChangeNotifier {
  List<List<Cell>> board = [];
  Snake snake;
  Direction direction = Direction.Down;
  Timer _timer;
  bool gamesOver = false;

  GameNotifier() {
    init();
  }

  init() {
    board = List<List<Cell>>.generate(15, (row) {
      return List<Cell>.generate(15, (col) => Cell(row, col));
    });

    direction = Direction.Left;
    snake = Snake(board[6][5]);
    initGameLoop();
    generateFood();
    notifyListeners();
  }

  void initGameLoop() {
    _timer = Timer.periodic(Duration(milliseconds:  500), (timer) {
      update();
      notifyListeners();
    });
  }

  void update()
  {
    if (!gamesOver) {
      if (direction != null) {
        Cell nextCell = getNextCell(snake.head);
        if (snake.checkCrash(nextCell)) {
          direction = null;
          _timer.cancel();
          gamesOver = true;
          notifyListeners();
        } else{
          if (nextCell.cellType == CellType.FOOD) {
            snake.grow(nextCell);
            generateFood();
          }
          snake.move(nextCell);
        }
      }
    }
  }

  Cell getNextCell(Cell currentPosition)
  {
    int row = currentPosition.row;
    int col = currentPosition.col;

    if (direction == Direction.Right) {
      col--;
    }
    else if (direction == Direction.Left) {
      col++;
    }
    else if (direction == Direction.Up) {
      row--;
    }
    else if (direction == Direction.Down) {
      row++;
    }

    if(col >= Snake.MAX){
      col = 0;
    } else if(col < 0){
      col = Snake.MAX - 1;
    }

    if(row >= Snake.MAX){
      row = 0;
    } else if(row < 0){
      row = Snake.MAX - 1;
    }


    Cell nextCell = board[row][col];

    return nextCell;
  }

  void generateFood() {
    int row = 0;
    int col = 0;
    while(true){
      row = (Math.Random().nextInt(board[0].length));
      col = (Math.Random().nextInt(board[0].length));
      if(board[row][col].cellType !=CellType.SNAKE_NODE)
        break;
    }
    board[row][col].cellType = (CellType.FOOD);
    notifyListeners();
  }

  void handleKeyPress(RawKeyEvent event) {
    if(event.logicalKey == LogicalKeyboardKey.arrowUp && direction != Direction.Left){
      direction = Direction.Right;
    } else if(event.logicalKey == LogicalKeyboardKey.arrowDown && direction != Direction.Right){
      direction = Direction.Left;
    } else if(event.logicalKey == LogicalKeyboardKey.arrowLeft && direction != Direction.Down){
      direction = Direction.Up;
    } else if(event.logicalKey == LogicalKeyboardKey.arrowRight && direction != Direction.Up){
      direction = Direction.Down;
    }
    notifyListeners();
  }
}
