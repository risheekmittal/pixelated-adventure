import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/level3.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/pause_menu.dart';

class PauseButton3 extends StatelessWidget {
  static const String id = 'PauseButton';
  final JoystickExample gameRef;

  const PauseButton3({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu6.id);
            gameRef.overlays.remove(PauseButton3.id);
          },
          icon: Icon(Icons.pause_rounded)),
    );
  }
}
