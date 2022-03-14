import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/title_bg.dart';
import 'package:flutter_slider_puzzle/title_screen.dart';

import 'components/player.dart';
import 'helpers/direction.dart';
import 'levels/level_1/level_1.dart';

double x1 = 0, y1 = 0;
bool flag = false;
bool flag2 = false;
int a = 0, b = 0, c = 0, i = 0;
int count = 0, counter = 0;
ValueNotifier reset = ValueNotifier(false);

class StartingScreen extends StatefulWidget {
  StartingScreen({Key? key}) : super(key: key);

  @override
  StartingScreenState createState() => StartingScreenState();
}

class StartingScreenState extends State<StartingScreen> {
  TitleScreen titleScreen = TitleScreen();

  @override
  void initState() {
    reset.addListener(() {
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LevelSelection()));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (reset != false) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => LevelOne()));
    // }
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: titleScreen,
          ),
          const Positioned(
            top: 50,
            left: 450,
            child: Text(
              'Pixelated',
              style: TextStyle(
                  fontFamily: 'RedPixel', color: Colors.red, fontSize: 50),
            ),
          ),
          const Positioned(
            top: 100,
            left: 450,
            child: Text(
              'Adventure',
              style: TextStyle(
                  fontFamily: 'RedPixel', color: Colors.red, fontSize: 50),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.2,
            left: MediaQuery.of(context).size.width / 1.44,
            child: Text(
              'hold to move the player',
              style: TextStyle(
                  fontFamily: 'WimCrouwel', color: Colors.white, fontSize: 20),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.2,
            left: MediaQuery.of(context).size.width / 3.6,
            child: Text(
              'move the tile to start the game',
              style: TextStyle(
                  fontFamily: 'WimCrouwel', color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleScreen extends FlameGame with HasCollidables, HasTappables {
  var numbers = [1, 2, 3, 4, 5, 6, 7, 0, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8];
  TitleBG titleBG = TitleBG();
  final Player _player = Player();
  // Bgm bgm = Bgm();
  late AudioPool pool;
  @override
  Future<void>? onLoad() async {
    // pool = await AudioPool.create('sounds/level-win-6416.mp3',
    //     minPlayers: 3, maxPlayers: 4);
    startBgmMusic();
    // bgm.initialize();
    // bgm.play('sounds/happy-14585.mp3');
    await add(titleBG);
    int index = numbers.indexOf(0);
    _player.y = size.y / 1.3;
    _player.x = size.x / 1.4;
    _player.size = Vector2.all(40);
    add(_player);
    double x = size.x / 7.2, y = size.y / 7.2;
    for (i = 0; i <= 8; i++) {
      if (i == 3 || i == 6) {
        x = size.x / 7.2;
        y += size.y / 3.6;
      }
      if (i < 3) {
        if (i == index) {
          add(Tile2(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          add(Tile1(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += size.x / 7.2;
        print(i);
      } else if (i < 6) {
        print(i);
        if (i == index) {
          add(Tile2(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          add(Tile1(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += size.x / 7.2;
      } else if (i <= 8) {
        print(i);
        if (i == index) {
          add(Tile2(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          add(Tile1(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += size.x / 7.2;
        print(i);
      }
    }
    final imageUp = await images.load('arrow_up.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: imageUp,
      columns: 3,
      rows: 2,
    );
    final imageDown = await images.load('arrow_down.png');
    final sheet2 = SpriteSheet.fromColumnsAndRows(
      image: imageDown,
      columns: 3,
      rows: 2,
    );
    add(Button(sheet.getSpriteById(3), sheet2.getSpriteById(3), _player,
        Direction.left, Vector2(550, 250)));
    return super.onLoad();
  }

  startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('happy-14585.mp3');
  }
}

class Tile1 extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  int index, index0;
  final numbers;
  Tile1(Sprite sprite, Vector2 vector2, this.index, this.numbers, this.index0)
      : super(
          sprite: sprite,
          size: Vector2.all(50),
          position: vector2,
        ) {
    if (numbers[index] != 0) {
      addHitbox(HitboxRectangle());
    }
  }

  Vector2 Tile1ize = Vector2.all(50);
  @override
  Future<void>? onLoad() {
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    i = index;
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 3 != 0 ||
        index + 1 < 9 && numbers[index + 1] == 0 && (index + 1) % 3 != 0 ||
        (index - 3 >= 0 && numbers[index - 3] == 0) ||
        (index + 3 < 9 && numbers[index + 3] == 0)) {
      if (flag == false) {
        x1 = x;
        y1 = y;
      }
      if (numbers.indexOf(0) == 0) {
        x = gameRef.size.x / 14.4; //50
        y = gameRef.size.y / 18; //20
      }
      if (numbers.indexOf(0) == 1) {
        y = gameRef.size.y / 18; //20
        x = gameRef.size.x / 3.2727; //220
      }
      if (numbers.indexOf(0) == 2) {
        y = gameRef.size.y / 18; //20
        x = gameRef.size.x / 1.84615; //390
      }
      if (numbers.indexOf(0) == 3) {
        y = gameRef.size.y / 2.77; //130
        x = gameRef.size.x / 14.4; //50
      }
      if (numbers.indexOf(0) == 4) {
        x = gameRef.size.x / 3.2727; //220
        y = gameRef.size.y / 2.77; //130
      }
      if (numbers.indexOf(0) == 5) {
        y = gameRef.size.y / 2.77; //130
        x = gameRef.size.x / 1.84615; //390
      }
      if (numbers.indexOf(0) == 6) {
        x = gameRef.size.x / 14.4; //50
        y = gameRef.size.y / 1.5; //240
      }
      if (numbers.indexOf(0) == 7) {
        x = gameRef.size.x / 4.8; //150
        y = gameRef.size.y / 1.44;
        print(x);
        print(y);
      }
      if (numbers.indexOf(0) == 8) {
        x = gameRef.size.x / 3.6; //200
        y = gameRef.size.y / 1.44;
        print(x);
        print(y);
      }
      if (flag == false) {
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
        a = index;
        FlameAudio.audioCache.play('cartoon-jump-6462.mp3');
        count++;
        reset.value = true;
      }
      flag = true;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    if (flag == true) {
      index = b;
    }
  }

  int returnIndex() {
    int a;
    a = index;
    return a;
  }
}

class Tile2 extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  int index;
  final numbers;
  int count = 0;
  Tile2(Sprite sprite, Vector2 vector2, this.index, this.numbers)
      : super(
          sprite: sprite,
          size: Vector2.all(0.0),
          position: vector2,
        ) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() {
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (x1 != 0 && y1 != 0 && flag2 == false) {
      x = x1;
      y = y1;
      b = index;

      flag2 = true;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    flag = false;
    flag2 = false;
    index = a;
  }
}
