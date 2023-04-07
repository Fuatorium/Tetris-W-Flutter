import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'tetrimino.dart';

const int numRows = 20;
const int numColumns = 10;
const Duration gameTickDuration = Duration(milliseconds: 500);



class TetrisBoard extends StatefulWidget {
  @override
  _TetrisBoardState createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  late List<List<Color>> _board;
  late Tetrimino _currentTetrimino;
  late int _currentRow;
  late int _currentColumn;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initBoard();
    _spawnTetrimino();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initBoard() {
    _board = List.generate(
        numRows, (_) => List.filled(numColumns, Colors.transparent));
  }

  void _spawnTetrimino() {
    _currentTetrimino = tetriminoList[Random().nextInt(tetriminoList.length)];
    _currentRow = 0;
    _currentColumn =
        (numColumns / 2).floor() - (_currentTetrimino.shape.length / 2).floor();
    if (!_isValidPosition(
        _currentTetrimino.shape, _currentRow, _currentColumn)) {
      _timer?.cancel();
      // Game Over
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(gameTickDuration, (_) => _update());
  }

  void _update() {
    setState(() {
      if (_isValidPosition(
          _currentTetrimino.shape, _currentRow + 1, _currentColumn)) {
        _currentRow++;
      } else {
        _placeTetrimino();
        _spawnTetrimino();
      }
    });
  }

  bool _isValidPosition(List<List<int>> shape, int row, int column) {
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          int boardY = row + y;
          int boardX = column + x;
          if (boardY < 0 || boardY >= numRows || boardX < 0 ||
              boardX >= numColumns ||
              _board[boardY][boardX] != Colors.transparent) {
            return false;
          }
        }
      }
    }
    return true;
  }

  void _moveTetriminoRight() {
    setState(() {
      if (_isValidPosition(
          _currentTetrimino.shape, _currentRow, _currentColumn + 1)) {
        _currentColumn++;
      }
    });
  }

  void _moveTetriminoLeft() {
    setState(() {
      if (_isValidPosition(
          _currentTetrimino.shape, _currentRow, _currentColumn - 1)) {
        _currentColumn--;
      }
    });
  }

  void _moveTetriminoDown() {
    setState(() {
      if (_isValidPosition(
          _currentTetrimino.shape, _currentRow + 1, _currentColumn)) {
        _currentRow++;
      } else {
        _placeTetrimino();
        _spawnTetrimino();
      }
    });
  }

  void _rotateTetrimino() {
    setState(() {
      List<List<int>> newShape = _currentTetrimino.rotatedRight();
      if (_isValidPosition(newShape, _currentRow, _currentColumn)) {
        _currentTetrimino.shape = newShape;
      }
    });
  }

  void _placeTetrimino() {
    for (int y = 0; y < _currentTetrimino.shape.length; y++) {
      for (int x = 0; x < _currentTetrimino.shape[y].length; x++) {
        if (_currentTetrimino.shape[y][x] == 1) {
          _board[_currentRow + y][_currentColumn + x] = _currentTetrimino.color;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _moveTetriminoRight();
        } else {
          _moveTetriminoLeft();
        }
      },
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy > 0) {
          _moveTetriminoDown();
        } else {
          _rotateTetrimino();
        }
      },
      child: AspectRatio(
        aspectRatio: numColumns / numRows,
        child: GridView.builder(
          itemCount: numRows * numColumns,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numColumns),
          itemBuilder: (BuildContext context, int index) {
            final int x = index % numColumns;
            final int y = index ~/ numColumns;
            Color cellColor = _board[y][x];
            if (_isValidPosition(_currentTetrimino.shape, y, x)) {
              final int tetriminoX = x - _currentColumn;
              final int tetriminoY = y - _currentRow;
              if (tetriminoY >= 0 &&
                  tetriminoY < _currentTetrimino.shape.length &&
                  tetriminoX >= 0 &&
                  tetriminoX < _currentTetrimino.shape[tetriminoY].length &&
                  _currentTetrimino.shape[tetriminoY][tetriminoX] == 1) {
                cellColor = _currentTetrimino.color;
              }
            }
            return Container(
              decoration: BoxDecoration(
                color: cellColor,
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
            );
          },
        ),
      ),
    );
  }
}


