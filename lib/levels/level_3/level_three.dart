import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/title_screen.dart';

import 'level_3.dart';

class LevelThree extends StatefulWidget {
  CheckWin checkWin;
  LevelThree({Key? key, required this.checkWin}) : super(key: key);

  @override
  _LevelThreeState createState() => _LevelThreeState();
}

class _LevelThreeState extends State<LevelThree> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int c = 0;
  bool isPaused = false;
  @override
  void initState() {
    super.initState();
    numbers.shuffle();
    numbers2.shuffle();
    startBgmMusic();
    FlameAudio.audioCache.play('winfantasia-6912.mp3');
  }

  @override
  Widget build(BuildContext context) {
    Level3 level3 = Level3(checkWin: widget.checkWin);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Container(
            height: size.height,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/level2.png')),
            ),
            child: Column(
              children: [
                Container(
                  height: size.height,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 3.6,
                        right: MediaQuery.of(context).size.width / 3.6,
                        top: MediaQuery.of(context).size.height / 3.6),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 25,
                                crossAxisSpacing: 75),
                        itemCount: numbers.length,
                        itemBuilder: (context, index) {
                          return numbers[index] != 0
                              ? ElevatedButton(
                                  onPressed: () => clickGrid(
                                      numbers2.indexOf(numbers[index])),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                )
                              : const SizedBox.shrink();
                        }),
                  ),
                )
              ],
            ),
          )),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isPaused = true;
                  });
                },
                icon: Icon(Icons.pause_rounded)),
          ),
          isPaused ? pauseMenu3(widget.checkWin) : Container(),
          c == 8 ? gameWon3() : Container(),
        ],
      ),
    );
  }

  void clickGrid(index) {
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 3 != 0 ||
        index + 1 < 9 && numbers[index + 1] == 0 && (index + 1) % 3 != 0 ||
        (index - 3 >= 0 && numbers[index - 3] == 0) ||
        (index + 3 < 9 && numbers[index + 3] == 0)) {
      setState(() {
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers2[numbers2.indexOf(0)] = numbers2[index];
        numbers[index] = 0;
        numbers2[index] = 0;
        FlameAudio.audioCache.play('slimejump-6913.mp3');
        isWin();
      });
    }
  }

  startBgmMusic() {
    FlameAudio.bgm.play('one-6779.mp3');
  }

  Widget pauseMenu3(CheckWin checkWin) {
    return ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.screen),
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
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
                          setState(() {
                            isPaused = false;
                          });
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
                                  builder: (context) => LevelThree(
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
      ),
    );
  }

  Widget gameWon3() {
    widget.checkWin.checkLevel2 = false;
    widget.checkWin.checkLevel3 = true;
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

  void isWin() {
    for (var i = 0; i <= 8; i++) {
      if (numbers[i] != numbers2[i]) {
        c = i;
        print(c);
        break;
      }
    }
  }
}
