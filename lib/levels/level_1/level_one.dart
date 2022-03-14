import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/pause_button.dart';
import 'package:flutter_slider_puzzle/components/pause_menu.dart';
import 'package:flutter_slider_puzzle/levels/level_1/game_over.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';

import '../../title_screen.dart';

class LevelOne extends StatefulWidget {
  CheckWin checkWin;
  LevelOne({Key? key, required this.checkWin}) : super(key: key);

  @override
  _LevelOneState createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  @override
  Widget build(BuildContext context) {
    Level1 level1 = Level1(checkWin: widget.checkWin);
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: level1, initialActiveOverlays: [
            PauseButton.id
          ], overlayBuilderMap: {
            PauseButton.id: (BuildContext context, Level1 gameRef) =>
                PauseButton(
                  gameRef: gameRef,
                ),
            PauseMenu.id: (BuildContext context, Level1 gameRef) => PauseMenu(
                  gameRef: gameRef,
                  checkWin: widget.checkWin,
                ),
            GameWon.id: (BuildContext context, Level1 gameRef) => GameWon(
                  gameRef: gameRef,
                ),
          })
        ],
      ),
    );
  }
}
