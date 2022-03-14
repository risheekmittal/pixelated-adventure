import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/pause_menu.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';

class PauseButton extends StatelessWidget {
  static const String id = 'PauseButton';
  final Level1 gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            gameRef.pauseEngine();
            gameRef.overlays.add(PauseMenu.id);
            gameRef.overlays.remove(PauseButton.id);
          },
          icon: Icon(Icons.pause_rounded)),
    );
  }
}
