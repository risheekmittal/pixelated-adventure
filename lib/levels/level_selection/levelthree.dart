import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/helpers/joypad.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/level3.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/pause_button.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/pause_menu.dart';
import 'package:flutter_slider_puzzle/title_screen.dart';

import 'game_won_3.dart';

class LevelNewPage extends StatefulWidget {
  LevelNewPage({Key? key, required this.checkWin}) : super(key: key);
  CheckWin checkWin;
  @override
  LevelNewState createState() => LevelNewState();
}

class LevelNewState extends State<LevelNewPage> {
  @override
  Widget build(BuildContext context) {
    JoystickExample _joystickExample =
        JoystickExample(checkWin: widget.checkWin);
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: _joystickExample, overlayBuilderMap: {
              PauseButton3.id:
                  (BuildContext context, JoystickExample gameRef) =>
                      PauseButton3(
                        gameRef: gameRef,
                      ),
              PauseMenu6.id: (BuildContext context, JoystickExample gameRef) =>
                  PauseMenu6(
                    gameRef: gameRef,
                    checkWin: widget.checkWin,
                  ),
              GameWon3.id: (BuildContext context, JoystickExample gameRef) =>
                  GameWon3(
                    gameRef: gameRef,
                  ),
            }),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Joypad(
                    onDirectionChanged:
                        _joystickExample.onJoypadDirectionChanged),
              ),
            )
          ],
        ));
  }
}
