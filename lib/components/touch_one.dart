import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/end_scene.dart';

class FirstLevel extends StatefulWidget {
  const FirstLevel({Key? key}) : super(key: key);

  @override
  _FirstLevelState createState() => _FirstLevelState();
}

class _FirstLevelState extends State<FirstLevel> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int c = 0;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Container(
      height: size.height,
      color: Colors.blue,
      child: Stack(
        children: [
          Positioned(
              left: MediaQuery.of(context).size.width / 1.2,
              top: MediaQuery.of(context).size.height / 1.2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  onPressed: () => shuffle(),
                  child: Text(
                    'reset',
                    style: TextStyle(color: Colors.grey),
                  ))),
          Container(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 3.2,
                  right: MediaQuery.of(context).size.width / 3.2,
                  top: MediaQuery.of(context).size.height / 8),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 50),
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return numbers[index] != 0
                        ? ElevatedButton(
                            onPressed: () => clickGrid(index),
                            child: Text(
                              "${numbers[index]}",
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          )
                        : const SizedBox.shrink();
                  }),
            ),
          )
        ],
      ),
    ));
  }

  void clickGrid(index) {
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 3 != 0 ||
        index + 1 < 9 && numbers[index + 1] == 0 && (index + 1) % 3 != 0 ||
        (index - 3 >= 0 && numbers[index - 3] == 0) ||
        (index + 3 < 9 && numbers[index + 3] == 0)) {
      setState(() {
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
        isWin();
        if (c == 8) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GameWidget(game: EndScene())));
        }
      });
    }
  }

  void isWin() {
    for (var i = 0; i <= 8; i++) {
      if (numbers[i] != numbers2[i]) {
        c = i;
        break;
      }
    }
  }

  void shuffle() {
    setState(() {
      numbers.shuffle();
    });
  }
}

class EndingState extends StatefulWidget {
  const EndingState({Key? key}) : super(key: key);

  @override
  _EndingStateState createState() => _EndingStateState();
}

class _EndingStateState extends State<EndingState> {
  EndScene endScene = EndScene();
  bool change = false;
  double opacity = 1.0;
  static const String description = '''
    THANK-YOU
    FOR
    PLAYING
  ''';

  @override
  void initState() {
    Future.delayed(Duration(seconds: 10), () {
      change = true;
    });
    changeOpacity();
    super.initState();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: change
          ? AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 1),
              child: Center(
                  child: Text(
                description,
                style: TextStyle(
                    fontFamily: 'RedPixel', fontSize: 80, color: Colors.white),
              )),
            )
          : Stack(
              children: [
                GameWidget(
                  game: endScene,
                )
              ],
            ),
    );
  }
}
