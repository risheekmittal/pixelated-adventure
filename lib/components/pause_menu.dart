import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/pause_button.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_one.dart';

import '../title_screen.dart';

class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  final Level1 gameRef;
  CheckWin checkWin;

  PauseMenu({Key? key, required this.gameRef, required this.checkWin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.screen),
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 1000,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        gameRef.resumeEngine();
                        gameRef.overlays.remove(PauseMenu.id);
                        gameRef.overlays.add(PauseButton.id);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        'Resume',
                        style: TextStyle(color: Colors.transparent),
                      ))),
              const Text(
                'Paused',
                style: TextStyle(
                    fontFamily: 'WimCrouwel',
                    color: Colors.white,
                    fontSize: 40,
                    shadows: [
                      Shadow(
                          blurRadius: 20.0,
                          color: Colors.white,
                          offset: Offset(0, 0))
                    ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 11,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                      onPressed: () {
                        gameRef.resumeEngine();
                        gameRef.overlays.remove(PauseMenu.id);
                        gameRef.overlays.add(PauseButton.id);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        'Resume',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LevelOne(
                                      checkWin: checkWin,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        'Restart',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenu.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        'Exit to Level Selection',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                  width: 1000,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        gameRef.resumeEngine();
                        gameRef.overlays.remove(PauseMenu.id);
                        gameRef.overlays.add(PauseButton.id);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(
                        'Resume',
                        style: TextStyle(color: Colors.transparent),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
