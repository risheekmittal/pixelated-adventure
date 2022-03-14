import 'package:flutter/material.dart';

class GameWon2 extends StatelessWidget {
  static const String id = 'GameWon2';
  GameWon2({Key? key}) : super(key: key);

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
                      onPressed: () {},
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
                'Level Clear',
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
                      onPressed: () {},
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
