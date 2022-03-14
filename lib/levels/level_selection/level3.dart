import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/rendering/object.dart';
import 'package:flutter_slider_puzzle/components/world.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';
import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';
import 'package:flutter_slider_puzzle/levels/level_4/background.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/game_won_3.dart';
import 'package:flutter_slider_puzzle/levels/level_selection/pause_button.dart';
import 'package:flutter_slider_puzzle/title_screen.dart';

class JoystickExample extends FlameGame with HasDraggables, HasCollidables {
  CheckWin checkWin;
  JoystickExample({required this.checkWin});
  late final JoystickComponent joystick;
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  static final defaultPaint = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke;
  final World _world = World();
  SpriteComponent tile0 = SpriteComponent();
  late final TextComponent moveText;
  late final TextComponent tileText;
  Player _player = Player();
  double x = 50, y = 20;
  int i = 0;

  @override
  Future<void> onLoad() async {
    print(size);

    numbers.shuffle();
    int index = numbers.indexOf(0);
    await add(World3());
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

    final _regularTextStyle =
        TextStyle(fontSize: 18, color: BasicPalette.white.color);
    final _regular = TextPaint(style: _regularTextStyle);
    // moveText = TextComponent(text: 'Moves: 0', textRenderer: _regular)
    //   ..anchor = Anchor.topCenter
    //   ..x = size.x / 1.2
    //   ..y = size.y / 4;
    tileText = TextComponent(text: 'Tiles Arranged: 0', textRenderer: _regular)
      ..anchor = Anchor.topCenter
      ..x = size.x / 1.2
      ..y = size.y / 3.2;
    add(tileText);
    // add(moveText);
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    // joystick = JoystickComponent(
    //   knob: CircleComponent(radius: 20, paint: knobPaint),
    //   background: CircleComponent(radius: 50, paint: backgroundPaint),
    //   margin: const EdgeInsets.only(left: 600, bottom: 40),
    // );

    add(_player);
    // add(joystick);
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  void update(double dt) async {
    super.update(dt);
    // moveText.text = 'Moves: $count';
    tileText.text = 'Tiles Arranged: $c';
    isWin();
    if (c == 8) {
      checkWin.checkLevel3 = false;
      checkWin.checkLevel4 = true;
      pauseEngine();
      overlays.remove(PauseButton3.id);
      this.overlays.add(GameWon3.id);
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
}

class Player extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  final double _playerSpeed = 300.0;

  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  Player() : super(size: Vector2.all(30.0)) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('ball.png');
    position = gameRef.size / 2;
    return super.onLoad();
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
    angle = delta;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    if (!_hasCollided) {
      _hasCollided = true;
      _collisionDirection = direction;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          moveRight(delta);
        }
        break;
      case Direction.none:
        break;
    }
  }
}
