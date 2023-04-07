import 'package:flutter/material.dart';
import 'tetris_game.dart';

void main() {
  runApp(TetrisApp());
}

class TetrisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TetrisGameScaffold(),
    );
  }
}

class TetrisGameScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Tetris  🎮',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: TetrisGame(),
    );
  }
}
