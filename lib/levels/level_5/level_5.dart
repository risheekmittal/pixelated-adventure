import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slider_puzzle/components/dino.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';
import 'package:flutter_slider_puzzle/levels/level_5/background.dart';
import 'package:flutter_slider_puzzle/levels/level_5/game_win_5.dart';
import 'package:flutter_slider_puzzle/levels/level_5/pause_button_5.dart';
import 'package:flutter_slider_puzzle/title_screen.dart';

double x1 = 0, y1 = 0;
bool flag = false;
bool flag2 = false;
int a = 0, b = 0, c = 0, i = 0;
int count = 0;
bool hasTouched = false;

class Level5 extends FlameGame
    with HasCollidables, HasDraggables, HasTappables {
  Level5({required this.checkWin});
  CheckWin checkWin;
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  bool isTrue = true;
  Random random = Random();
  Dino dino = Dino();
  int row = 9;
  int col = 2;
  static final defaultPaint = BasicPalette.white.paint()
    ..style = PaintingStyle.stroke;
  late final TextComponent moveText;
  late final TextComponent tileText;
  double x = 50, y = 20;

  startBgmMusic() {
    FlameAudio.bgm.play('taratata-6264.mp3');
  }

  @override
  Future<void>? onLoad() async {
    startBgmMusic();
    FlameAudio.audioCache.play('winfantasia-6912.mp3');
    await add(World4());
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

    final image = await images.load('ladder.png');
    final sheet1 = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 7,
      rows: 1,
    );
    add(Water());
    add(Ladder(sheet1.getSpriteById(0)));
    add(Bridge(Vector2(size.x / 14, size.y / 4)));
    add(Bridge(Vector2(size.x / 14, size.y / 1.8)));
    add(Bridge(Vector2(size.x / 14, size.y / 1.2)));
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
    add(Button2(sheet.getSpriteById(1), sheet2.getSpriteById(1), Direction.up,
        Vector2(size.x * 0.8333, size.y * 0.5555), dino));
    add(Button2(sheet.getSpriteById(3), sheet2.getSpriteById(3), Direction.left,
        Vector2(size.x * 0.763888, size.y * 0.69444), dino));
    add(Button2(sheet.getSpriteById(5), sheet2.getSpriteById(5),
        Direction.right, Vector2(size.x * 0.902777, size.y * 0.69444), dino));
    add(Button2(sheet.getSpriteById(4), sheet2.getSpriteById(4), Direction.down,
        Vector2(size.x * 0.8333, size.y * 0.8333), dino));
    add(Kick(dino, Vector2(size.x * 0.805555, size.y * 0.41666)));
    final _regularTextStyle =
        TextStyle(fontSize: 18, color: BasicPalette.white.color);
    final _regular = TextPaint(style: _regularTextStyle);
    tileText = TextComponent(text: 'Tiles Arranged: 0', textRenderer: _regular)
      ..anchor = Anchor.topCenter
      ..x = size.x / 1.2
      ..y = size.y / 3.2;
    add(tileText);
    add(dino);
    return super.onLoad();
  }

  @override
  void update(double dt) async {
    dino.removeHitbox(HitboxRectangle());
    isWin();
    tileText.text = 'Tiles Arranged: $c';
    if (c == 8) {
      checkWin.checkLevel4 = false;
      checkWin.checkLevel5 = true;
      pauseEngine();
      overlays.remove(PauseButton5.id);
      this.overlays.add(GameWon5.id);
    }
    super.update(dt);
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

class Button2 extends SpriteButtonComponent {
  Dino dino;
  Direction direction;
  Vector2 position1;
  Button2(
      Sprite sprite, Sprite sprite2, this.direction, this.position1, this.dino)
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
    dino.direction = direction;
    return super.onTapDown(_);
  }

  @override
  bool onTapCancel() {
    dino.direction = Direction.none;
    return super.onTapCancel();
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
    if (hasTouched == true) {
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
          count++;
          FlameAudio.audioCache.play('slimejump-6913.mp3');
        }
        flag = true;
      }
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

class Kick extends SpriteButtonComponent with HasGameRef {
  final _player;
  Vector2 position1;
  Kick(this._player, this.position1)
      : super(position: position1, size: Vector2(100, 50), onPressed: () {});

  @override
  Future<void>? onLoad() async {
    final imageDown = await gameRef.images.load('buttons.png');
    final sheet2 = SpriteSheet.fromColumnsAndRows(
      image: imageDown,
      columns: 2,
      rows: 3,
    );
    button = sheet2.getSpriteById(2);
    buttonDown = sheet2.getSpriteById(3);
    return super.onLoad();
  }

  @override
  bool onTapUp(TapUpInfo _) {
    hasTouched = false;
    return super.onTapUp(_);
  }

  @override
  bool onTapDown(TapDownInfo _) {
    FlameAudio.audioCache.play('ouch-sound-effect-30-11844.mp3');

    hasTouched = true;
    return super.onTapDown(_);
  }

  @override
  bool onTapCancel() {
    hasTouched = false;
    return super.onTapCancel();
  }
}
