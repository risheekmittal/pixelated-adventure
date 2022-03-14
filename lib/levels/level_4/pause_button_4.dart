import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/pause_menu.dart';

import 'level_4.dart';

class PauseButton4 extends StatelessWidget {
  static const String id = 'PauseButton';
  final Level4 gameRef;

  const PauseButton4({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu.id);
            gameRef.overlays.remove(PauseButton4.id);
          },
          icon: Icon(Icons.pause_rounded)),
    );
  }
}
