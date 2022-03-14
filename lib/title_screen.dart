import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_one.dart';
import 'package:flutter_slider_puzzle/levels/level_5/level_five.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'levels/level_3/level_three.dart';
import 'levels/level_selection/levelthree.dart';

class LevelSelection extends StatefulWidget {
  const LevelSelection({Key? key}) : super(key: key);

  @override
  _LevelSelectionState createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  @override
  CarouselController carouselController = CarouselController();
  ValueNotifier value = ValueNotifier(1);
  int i = -1;
  CheckWin checkWin = CheckWin(
      checkLevel1: true,
      checkLevel2: false,
      checkLevel3: false,
      checkLevel4: false,
      checkLevel5: false);

  final featuredImages = [
    'assets/images/Grassy Scope.png',
    'assets/images/Grassy Scope (2).png',
    'assets/images/Grassy Scope (3).png',
    'assets/images/Grassy Scope (1).png'
  ];

  startBgmMusic() {
    FlameAudio.bgm.play('happy-14585.mp3');
  }

  @override
  void initState() {
    startBgmMusic();
    checkLevelClear();
    super.initState();
  }

  void checkLevelClear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkWin.checkLevel1 = (prefs.getBool('level1') ?? true);
      checkWin.checkLevel2 = (prefs.getBool('level2') ?? false);
      checkWin.checkLevel3 = (prefs.getBool('level3') ?? false);
      checkWin.checkLevel4 = (prefs.getBool('level4') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    //extra non-relevant code in here
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.orange
            // image: DecorationImage(image: AssetImage('name'));
            ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 1.2,
                child: GestureDetector(
                  onTap: () {
                    if (value.value == 1 && checkWin.checkLevel1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LevelOne(
                                    checkWin: checkWin,
                                  )));
                    } else if (value.value == 2 && checkWin.checkLevel2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LevelThree(
                                    checkWin: checkWin,
                                  )));
                    } else if (value.value == 3 && checkWin.checkLevel3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LevelNewPage(
                                    checkWin: checkWin,
                                  )));
                    } else if (value.value == 4 && checkWin.checkLevel4) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LevelFive(
                                    checkWin: checkWin,
                                  )));
                    }
                  },
                  child: Row(
                    children: [
                      CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: featuredImages.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          final checks = [
                            checkWin.checkLevel1,
                            checkWin.checkLevel2,
                            checkWin.checkLevel3,
                            checkWin.checkLevel4,
                            checkWin.checkLevel4,
                          ];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: ColorFiltered(
                                colorFilter: checks[index]
                                    ? ColorFilter.mode(
                                        Colors.transparent,
                                        BlendMode.multiply,
                                      )
                                    : ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.saturation,
                                      ),
                                child: Stack(
                                  children: [
                                    Center(
                                        child:
                                            Image.asset(featuredImages[index])),
                                    checks[index]
                                        ? Container()
                                        : Center(
                                            child: Image.asset(
                                            'assets/images/lock.png',
                                            height: 50,
                                            width: 50,
                                          )),
                                  ],
                                )),
                          );
                        },
                        options: CarouselOptions(
                            pageViewKey:
                                PageStorageKey<String>('carousal slider'),
                            onScrolled: (double? index) {
                              index = index! + 1;
                              setState(() {
                                value.value = index;
                              });
                            },
                            aspectRatio: 1.71,
                            enlargeCenterPage: true,
                            pauseAutoPlayInFiniteScroll: true,
                            enableInfiniteScroll: false),
                      ),
                      // CarouselSlider(
                      //   carouselController:
                      //       carouselController, // Give the controller
                      //   options: CarouselOptions(
                      //       pageViewKey: PageStorageKey<String>('carousal slider'),
                      //       onScrolled: (double? index) {
                      //         index = index! + 1;
                      //         setState(() {
                      //           value.value = index;
                      //         });
                      //       },
                      //       aspectRatio: 0.1,
                      //       enlargeCenterPage: true,
                      //       pauseAutoPlayInFiniteScroll: true,
                      //       enableInfiniteScroll: false),
                      //   items: featuredImages.map((featuredImage) {
                      //     final checks = [
                      //       checkWin.checkLevel1,
                      //       checkWin.checkLevel2,
                      //       checkWin.checkLevel3,
                      //       checkWin.checkLevel4,
                      //       checkWin.checkLevel4,
                      //     ];
                      //     // if (i < 3) {
                      //     //   i++;
                      //     //   print(i);
                      //     //   print(checks[i]);
                      //     // }
                      //     // print(i);
                      //     return Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 7),
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('lock.png'))),
                      //         child: ColorFiltered(
                      //             colorFilter: checks[index]
                      //             ? ColorFilter.mode(
                      //                 Colors.transparent,
                      //                 BlendMode.multiply,
                      //               )
                      //             : ColorFilter.mode(
                      //                 Colors.grey,
                      //                 BlendMode.saturation,
                      //               ),
                      //             child: Image.asset(featuredImage)),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.previousPage();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    carouselController.nextPage();
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 5,
                left: MediaQuery.of(context).size.width / 3.5,
                child: Text(
                  '#${value.value.ceil()}',
                  style: TextStyle(
                      fontFamily: 'WimCrouwel',
                      color: Colors.white,
                      fontSize: 60),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ColorFilter gray(int j) {
    print('j = $j');
    final checks = [
      checkWin.checkLevel1,
      checkWin.checkLevel2,
      checkWin.checkLevel3,
      checkWin.checkLevel4,
    ];
    ColorFilter colorFiltered = ColorFilter.mode(
      Colors.transparent,
      BlendMode.multiply,
    );
    if (j > 4) {
      j = j - 4;
    }
    if (j < 4) {
      if (checks[j]) {
        colorFiltered = ColorFilter.mode(
          Colors.transparent,
          BlendMode.multiply,
        );
      } else {
        colorFiltered = ColorFilter.mode(
          Colors.grey,
          BlendMode.saturation,
        );
      }
    }
    print('colorfilter = $colorFiltered');
    return colorFiltered;
  }
}

class CheckWin {
  bool checkLevel1;
  bool checkLevel2;
  bool checkLevel3;
  bool checkLevel4;
  bool checkLevel5;

  CheckWin(
      {required this.checkLevel1,
      required this.checkLevel2,
      required this.checkLevel3,
      required this.checkLevel4,
      required this.checkLevel5});
}
