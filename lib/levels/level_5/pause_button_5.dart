import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/pause_menu.dart';
import 'package:flutter_slider_puzzle/levels/level_5/pause_menu_5.dart';

import 'level_5.dart';

class PauseButton5 extends StatelessWidget {
  static const String id = 'PauseButton';
  final Level5 gameRef;

  const PauseButton5({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu5.id);
            gameRef.overlays.remove(PauseButton5.id);
          },
          icon: Icon(Icons.pause_rounded)),
    );
  }
}
