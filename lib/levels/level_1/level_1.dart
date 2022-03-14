import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/ball.dart';
import 'package:flutter_slider_puzzle/components/pause_button.dart';

import '../../components/player.dart';
import '../../components/world.dart';
import '../../helpers/direction.dart';
import '../../title_screen.dart';
import 'game_over.dart';

double x1 = 0, y1 = 0;
bool flag = false;
bool flag2 = false;
int a = 0, b = 0, c = 0, i = 0;
int count = 0;

class Level1 extends FlameGame with HasCollidables, HasTappables {
  CheckWin checkWin;
  MyTextBox textBox = MyTextBox(
    '"Hello dear player. '
    'Hope you are doing well... If you are wondering the purpose of this level '
    'lemme give you a hint. The concept is super easy." '
    '                             '
    "Press the buttons to move the player.  "
    'Objective : Arrange the tiles in correct order to proceed.',
  );
  Level1({required this.checkWin});
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  static final defaultPaint = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke;
  final World _world = World();
  final Player _player = Player();
  SpriteComponent tile0 = SpriteComponent();
  late final TextComponent moveText;
  late final TextComponent tileText;
  double x = 50, y = 20;
  int i = 0;

  @override
  Future<void> onLoad() async {
    print(size);
    FlameAudio.audioCache.play('winfantasia-6912.mp3');
    numbers.shuffle();
    int index = numbers.indexOf(0);
    await add(_world);
    add(_player);
    for (i = 0; i <= 8; i++) {
      if (i == 3 || i == 6) {
        x = 50;
        y += 110;
      }
      if (i < 3) {
        if (i == index) {
          add(Tile0(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          add(Tiles(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += 170;
        print(i);
      } else if (i < 6) {
        print(i);
        if (i == index) {
          add(Tile0(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          add(Tiles(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += 170;
      } else if (i <= 8) {
        print(i);
        if (i == index) {
          add(Tile0(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          add(Tiles(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += 170;
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
    add(Button(sheet.getSpriteById(1), sheet2.getSpriteById(1), _player,
        Direction.up, Vector2(600, 200)));
    add(Button(sheet.getSpriteById(3), sheet2.getSpriteById(3), _player,
        Direction.left, Vector2(550, 250)));
    add(Button(sheet.getSpriteById(5), sheet2.getSpriteById(5), _player,
        Direction.right, Vector2(650, 250)));
    add(Button(sheet.getSpriteById(4), sheet2.getSpriteById(4), _player,
        Direction.down, Vector2(600, 300)));
    final _regularTextStyle =
        TextStyle(fontSize: 18, color: BasicPalette.white.color);
    final _regular = TextPaint(style: _regularTextStyle);
    tileText = TextComponent(text: 'Tiles Arranged: 0', textRenderer: _regular)
      ..anchor = Anchor.topCenter
      ..x = size.x / 1.2
      ..y = size.y / 3.2;
    add(tileText);
    add(
      textBox
        ..anchor = Anchor.bottomLeft
        ..y = size.y,
    );
  }

  @override
  void update(double dt) async {
    super.update(dt);
    Future.delayed(Duration(seconds: 15), () {
      remove(textBox);
    });
    isWin();
    tileText.text = 'Tiles Arranged: $c';
    if (c == 8) {
      checkWin.checkLevel1 = false;
      checkWin.checkLevel2 = true;
      pauseEngine();
      overlays.remove(PauseButton.id);
      this.overlays.add(GameWon.id);
    }
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  void isWin() {
    for (var i = 0; i <= 8; i++) {
      if (numbers[i] != numbers2[i]) {
        c = i;
        // print(c);
        break;
      }
    }
  }
}

class Tiles extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  int index, index0;
  final numbers;
  Tiles(Sprite sprite, Vector2 vector2, this.index, this.numbers, this.index0)
      : super(
          sprite: sprite,
          size: Vector2.all(50),
          position: vector2,
        ) {
    if (numbers[index] != 0) {
      addHitbox(HitboxRectangle());
    }
  }

  Vector2 tileSize = Vector2.all(50);
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
        x = 50;
        y = 20;
      }
      if (numbers.indexOf(0) == 1) {
        y = 20;
        x = 220;
      }
      if (numbers.indexOf(0) == 2) {
        y = 20;
        x = 390;
      }
      if (numbers.indexOf(0) == 3) {
        y = 130;
        x = 50;
      }
      if (numbers.indexOf(0) == 4) {
        x = 220;
        y = 130;
      }
      if (numbers.indexOf(0) == 5) {
        y = 130;
        x = 390;
      }
      if (numbers.indexOf(0) == 6) {
        x = 50;
        y = 240;
      }
      if (numbers.indexOf(0) == 7) {
        x = 220;
        y = 240;
      }
      if (numbers.indexOf(0) == 8) {
        x = 390;
        y = 240;
      }
      if (flag == false) {
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
        a = index;
        FlameAudio.audioCache.play('slimejump-6913.mp3');
        count++;
        print(numbers);
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

class Tile0 extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  int index;
  final numbers;
  int count = 0;
  Tile0(Sprite sprite, Vector2 vector2, this.index, this.numbers)
      : super(
          sprite: sprite,
          size: Vector2.all(5.0),
          position: vector2,
        ) {
    addHitbox(HitboxRectangle(relation: Vector2.all(1)));
    // debugMode = true;
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

class Button extends SpriteButtonComponent {
  final _player, direction;
  Vector2 position1;
  Button(Sprite sprite, Sprite sprite2, this._player, this.direction,
      this.position1)
      : super(
            button: sprite,
            buttonDown: sprite2,
            position: position1,
            size: Vector2.all(50),
            onPressed: () {});

  @override
  Future<void>? onLoad() {
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo _) {
    FlameAudio.audioCache.play('mixkit-video-game-retro-click-237.wav');
    _player.direction = direction;
    return super.onTapDown(_);
  }

  @override
  bool onTapUp(TapUpInfo _) {
    _player.direction = Direction.none;
    return super.onTapUp(_);
  }

  @override
  bool onTapCancel() {
    _player.direction = Direction.none;
    return super.onTapCancel();
  }
}

class Ball extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  bool hasCollided = false;
  Direction ballXDirection = Direction.right;
  Direction ballYDirection = Direction.down;
  Platform platform = Platform();
  List<List<double>> tile;

  Ball({required this.tile});

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('ball.png');
    size = Vector2.all(20);
    position = Vector2(gameRef.size.x / 1.2, gameRef.size.y / 2);
    addHitbox(HitboxCircle());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) async {
    super.onCollision(intersectionPoints, other);
    if (!hasCollided) {
      hasCollided = true;
    }
    if (hasCollided == true) {
      double leftSideDist = tile[i][0] - x;
      double rightSideDist = tile[i][0] + 50 - x;
      double topSideDist = tile[i][1] - y;
      double bottomSideDist = tile[i][1] + 50 - y;
      print(i);
      print(
          "bottom = $bottomSideDist and tile = ${tile[i][0]} and y = $y also x = $x");
      String min =
          findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
      print(min);

      switch (min) {
        case 'left':
          ballXDirection = Direction.left;
          break;
        case 'right':
          ballXDirection = Direction.right;
          break;
        case 'top':
          ballYDirection = Direction.up;
          break;
        case 'down':
          ballYDirection = Direction.down;
          break;
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    hasCollided = false;
  }

  String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];
    if (a < 0) {
      a = -a;
    }
    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < 0) {
        myList[i] = -myList[i];
        if (myList[i] < currentMin) {
          currentMin = myList[i];
        }
      } else {
        if (myList[i] < currentMin) {
          currentMin = myList[i];
        }
      }
    }
    print(myList);
    print(currentMin);
    if (currentMin == a) {
      return 'left';
    } else if (currentMin == b) {
      return 'right';
    } else if (currentMin == c) {
      return 'top';
    } else if (currentMin == d) {
      return "down";
    }
    return '';
  }
}

final _regularTextStyle =
    TextStyle(fontSize: 18, color: BasicPalette.white.color);
final _regular = TextPaint(style: _regularTextStyle);
final _box = _regular.copyWith(
  (style) => style.copyWith(
    color: Colors.lightGreenAccent,
    fontFamily: 'monospace',
    letterSpacing: 2.0,
  ),
);

class MyTextBox extends TextBoxComponent {
  MyTextBox(String text)
      : super(
          text: text,
          textRenderer: _box,
          boxConfig: TextBoxConfig(
            maxWidth: 400,
            timePerChar: 0.05,
            growingBox: true,
            margins: const EdgeInsets.all(25),
          ),
        );

  @override
  void drawBackground(Canvas c) {
    final rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(rect, Paint()..color = Colors.black38);
  }
}
