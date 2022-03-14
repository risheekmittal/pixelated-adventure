import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slider_puzzle/components/ball.dart';
import 'package:flutter_slider_puzzle/components/world.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';

class Level2 extends FlameGame with HasCollidables, HasDraggables {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 0];
  int row = 9;
  int col = 2;
  late Ball ball;
  static final defaultPaint = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke;
  late final TextComponent moveText;
  late final TextComponent tileText;
  double x = 50, y = 20;
  Platform platform = Platform();

  @override
  Future<void>? onLoad() async {
    await add(World());
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
    ball = Ball(tile: tile);
    add(ball);
    add(platform);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    moveBall();
    changeDirection();
  }

  void moveBall() {
    if (ball.ballYDirection == Direction.up) {
      ball.y -= 4;
    } else if (ball.ballYDirection == Direction.down) {
      ball.y += 4;
    }

    if (ball.ballXDirection == Direction.left) {
      ball.x -= 4;
    } else if (ball.ballXDirection == Direction.right) {
      ball.x += 4;
    }
  }

  void changeDirection() {
    if (ball.x >= platform.x / 1.03 &&
        ball.y <= (platform.y + 100) &&
        ball.y >= platform.y) {
      ball.ballXDirection = Direction.left;
    }
    if (ball.x <= 0) {
      ball.ballXDirection = Direction.right;
    }
    if (ball.x > size.x - 24) {
      ball.ballXDirection = Direction.none;
      ball.ballYDirection = Direction.none;
    }
    if (ball.y >= size.y) {
      ball.ballYDirection = Direction.up;
    } else if (ball.y <= 0) {
      ball.ballYDirection = Direction.down;
    }
  }
}
