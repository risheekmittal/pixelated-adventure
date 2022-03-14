import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'level_2.dart';

class LevelTwo extends StatefulWidget {
  const LevelTwo({Key? key}) : super(key: key);

  @override
  _LevelTwoState createState() => _LevelTwoState();
}

class _LevelTwoState extends State<LevelTwo> {
  Level2 level2 = Level2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: level2,
          )
        ],
      ),
    );
  }
}
