import 'package:flutter/material.dart';

class Tetrimino {
  late final List<List<int>> shape;
  final Color color;

  Tetrimino({required this.shape, required this.color});

  Tetrimino rotate() {
    final List<List<int>> newShape = List.generate(shape.length, (_) => List.filled(shape.length, 0));
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        newShape[x][shape.length - 1 - y] = shape[y][x];
      }
    }
    return Tetrimino(shape: newShape, color: color);
  }

  rotatedRight() {}


}

final List<Tetrimino> tetriminoList = [
  Tetrimino(shape: [
    [1, 1, 1],
    [0, 1, 0],
    [0, 0, 0],
  ], color: Colors.cyan),
  Tetrimino(shape: [
    [1, 1],
    [1, 1],
  ], color: Colors.yellow),
  Tetrimino(shape: [
    [1, 1, 0],
    [0, 1, 1],
    [0, 0, 0],
  ], color: Colors.red),
  Tetrimino(shape: [
    [0, 1, 1],
    [1, 1, 0],
    [0, 0, 0],
  ], color: Colors.green),
  Tetrimino(shape: [
    [1, 1, 1, 1],
    [0, 0, 0, 0],
  ], color: Colors.blue),
  Tetrimino(shape: [
    [1, 1, 0],
    [0, 1, 1],
    [0, 0, 0],
  ], color: Colors.orange),
  Tetrimino(shape: [
    [0, 1, 1],
    [1, 1, 0],
    [0, 0, 0],
  ], color: Colors.purple),
];
  List<List<int>> rotatedRight() {
    var shape;
    int numRows = shape.length;
    int numCols = shape[0].length;
    List<List<int>> newShape = List.generate(numCols, (_) => List.filled(numRows, 0));

    for (int row = 0; row < numRows; row++) {
      for (int col = 0; col < numCols; col++) {
        newShape[col][numRows - row - 1] = shape[row][col];
      }
    }

    return newShape;
  }

