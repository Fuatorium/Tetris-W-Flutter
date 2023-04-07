import 'package:flutter/material.dart';
import 'tetris_board.dart';

class TetrisGame extends StatefulWidget {
  @override
  _TetrisGameState createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TetrisBoard(),
      ),
    );
  }
}
