import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slider_puzzle/components/bomb.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';
import 'package:flutter_slider_puzzle/levels/level_4/background.dart';

Bomb bomb = Bomb();
Timer bombTimer = Timer(6, repeat: true);

class Level4 extends FlameGame
    with HasCollidables, HasDraggables, HasTappables {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 0];
  bool isTrue = true;
  Random random = Random();
  int row = 9;
  int col = 2;
  static final defaultPaint = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke;
  late final TextComponent moveText;
  late final TextComponent tileText;
  double x = 50, y = 20;

  @override
  Future<void>? onLoad() async {
    await add(World3());
    numbers.shuffle();
    var tile = List.generate(row, (i) => List.filled(col, 0.0, growable: false),
        growable: false);
    int index = numbers.indexOf(0);
    int i;
    for (i = 0; i <= 8; i++) {
      if (i == 3 || i == 6) {
        x = 50;
        y += 110;
      }
      if (i < 3) {
        if (i == index) {
          tile[i][0] = x;
          tile[i][1] = y;
          add(Tile0(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          tile[i][0] = x;
          tile[i][1] = y;
          add(Tiles(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += 170;
        print(i);
      } else if (i < 6) {
        print(i);
        if (i == index) {
          tile[i][0] = x;
          tile[i][1] = y;
          add(Tile0(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          tile[i][0] = x;
          tile[i][1] = y;
          add(Tiles(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += 170;
      } else if (i <= 8) {
        print(i);
        if (i == index) {
          tile[i][0] = x;
          tile[i][1] = y;
          add(Tile0(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers));
        } else {
          tile[i][0] = x;
          tile[i][1] = y;
          add(Tiles(await loadSprite("(${numbers[i]}).png"), Vector2(x, y), i,
              numbers, index));
        }
        x += 170;
        print(i);
      }
    }

    bombTimer.onTick = () {
      Bomb bomb2 = Bomb();
      bomb2
        ..position = Vector2(720 / 1.2, 0)
        ..size = Vector2(44, 58);
      add(bomb2);
    };

    bombTimer.repeat = true;
    bombTimer.start();
    return super.onLoad();
  }

  @override
  void update(double dt) async {
    bomb.y++;
    if (bomb.y > 300) {
      remove(bomb);
    }
    bombTimer.update(dt);
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
    add(Button2(sheet.getSpriteById(1), sheet2.getSpriteById(1),
        Direction.right, Vector2(600, 200), bomb));
    add(Button2(sheet.getSpriteById(3), sheet2.getSpriteById(3), Direction.left,
        Vector2(550, 250), bomb));
    super.update(dt);
  }
}

class Button2 extends SpriteButtonComponent {
  Bomb bomb;
  Direction direction;
  Vector2 position1;
  Button2(
      Sprite sprite, Sprite sprite2, this.direction, this.position1, this.bomb)
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
    if (direction == Direction.left) {
      bomb.x = bomb.x + 20;
    } else if (direction == Direction.right) {
      bomb.x = bomb.x + 20;
    }
    bomb.direction = direction;
    return super.onTapDown(_);
  }

  @override
  bool onTapCancel() {
    bomb.direction = Direction.none;
    return super.onTapCancel();
  }
}
