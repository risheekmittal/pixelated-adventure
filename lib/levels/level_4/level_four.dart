import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_puzzle/levels/level_4/pause_button_4.dart';
import 'package:flutter_slider_puzzle/levels/level_4/pause_menu_4.dart';

import 'level_4.dart';

class LevelFour extends StatefulWidget {
  const LevelFour({Key? key}) : super(key: key);

  @override
  _LevelFourState createState() => _LevelFourState();
}

class _LevelFourState extends State<LevelFour> {
  Level4 level4 = Level4();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: level4, initialActiveOverlays: [
            PauseButton4.id
          ], overlayBuilderMap: {
            PauseButton4.id: (BuildContext context, Level4 gameRef) =>
                PauseButton4(
                  gameRef: gameRef,
                ),
            PauseMenu4.id: (BuildContext context, Level4 gameRef) => PauseMenu4(
                  gameRef: gameRef,
                ),
          })
        ],
      ),
    );
  }
}
