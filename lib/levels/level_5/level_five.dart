import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/end_scene.dart';
import 'package:flutter_slider_puzzle/levels/level_5/game_win_5.dart';
import 'package:flutter_slider_puzzle/levels/level_5/level_5.dart';
import 'package:flutter_slider_puzzle/levels/level_5/pause_button_5.dart';
import 'package:flutter_slider_puzzle/levels/level_5/pause_menu_5.dart';
import 'package:flutter_slider_puzzle/title_screen.dart';

class LevelFive extends StatefulWidget {
  LevelFive({Key? key, required this.checkWin}) : super(key: key);
  CheckWin checkWin;

  @override
  _LevelFiveState createState() => _LevelFiveState();
}

class _LevelFiveState extends State<LevelFive> {
  EndScene endScene = EndScene();

  @override
  Widget build(BuildContext context) {
    print(widget.checkWin.checkLevel5);
    Level5 level5 = Level5(checkWin: widget.checkWin);
    return Scaffold(
      body: Stack(
        children: [
          widget.checkWin.checkLevel5
              ? GameWidget(game: endScene)
              : GameWidget(game: level5, initialActiveOverlays: [
                  PauseButton5.id
                ], overlayBuilderMap: {
                  PauseButton5.id: (BuildContext context, Level5 gameRef) =>
                      PauseButton5(
                        gameRef: gameRef,
                      ),
                  PauseMenu5.id: (BuildContext context, Level5 gameRef) =>
                      PauseMenu5(
                        gameRef: gameRef,
                        checkWin: widget.checkWin,
                      ),
                  GameWon5.id: (BuildContext context, Level5 gameRef) =>
                      GameWon5(
                        gameRef: gameRef,
                      ),
                })
        ],
      ),
    );
  }
}
