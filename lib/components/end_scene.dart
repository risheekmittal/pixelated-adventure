import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_slider_puzzle/components/dino.dart';
import 'package:flutter_slider_puzzle/components/endscene_bg.dart';
import 'package:flutter_slider_puzzle/components/player.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';
import 'package:flutter_slider_puzzle/title_bg.dart';

class EndScene extends FlameGame with HasCollidables {
  TitleBG titleBG = TitleBG();
  Player player = Player();
  Zombie zombie = Zombie();
  Dino dino = Dino();
  late Sprite sprite;
  SpriteComponent trophy = SpriteComponent();
  SpriteComponent platform = SpriteComponent();
  SpriteComponent question = SpriteComponent();
  SpriteComponent bomb = SpriteComponent();
  int counter = 0;

  @override
  Future<void>? onLoad() async {
    await add(EndSceneBG());
    platform
      ..sprite = await loadSprite('Component 1.png')
      ..position = Vector2(size.x / 2.6, size.y / 2.2)
      ..size = Vector2(size.x / 3.6, size.y / 3.6);

    dino.position = Vector2(size.x / 2.4, size.y / 1.6);
    dino.size = Vector2.all(size.x / 18);
    dino.removeHitbox(HitboxRectangle());

    player.position = Vector2(0, size.y / 1.2857);
    player.playerSpeed = 100;
    player.removeHitbox(HitboxRectangle());
    player.size = Vector2.all(size.x / 36);
    question
      ..sprite = await loadSprite('question.png')
      ..position = Vector2(size.x / 2.2, size.y / 2.5)
      ..size = Vector2(size.x / 24, size.y / 9);
    bomb
      ..sprite = await loadSprite('ball.png')
      ..position = Vector2(size.x / 2.2, size.y / 2.5)
      ..size = Vector2(size.x / 24, size.y / 9);
    add(question);
    add(player);
    add(platform);
    add(dino);
    add(bomb);
    add(zombie);

    zombie.position = Vector2(size.x, size.y / 2.5);
    trophy
      ..sprite = await loadSprite('trophy.png')
      ..position = zombie.position + Vector2(size.x / 24, size.y / 5)
      ..angle = 1.04719
      ..size = Vector2(size.x / 28, size.y / 14);
    add(trophy);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    bomb.position = Vector2(size.x / 1.6, size.y / 2);
    bomb.size = Vector2.all(size.x / 1000);
    player.direction = Direction.right;

    if (player.x > size.x / 1.8) {
      player.direction = Direction.down;
      if (player.size.x > size.x / 24) {
        player.direction = Direction.none;
      } else {
        player.size.add(Vector2.all(0.1));
        player.position.add(Vector2(0, -1.275));
      }
      player.playerSpeed = 0;
    }
    if (zombie.x > size.x / 2) {
      zombie.position.add(Vector2(-1, 0));
      trophy.position.add(Vector2(-1, 0));
      // Future.delayed(Duration(milliseconds: 4800), () {
      //   zombie.animation = zombie.attackAnimation;
      //   Future.delayed(Duration(milliseconds: 200), () {
      //     zombie.animation = zombie.dieAnimation;
      //   });
      // });

    } else {
      if (zombie.y > size.y / 2.9) {
        zombie.position.add(Vector2(0, -0.5));
        zombie.animation = zombie.attackAnimation;

        if (counter == 0) {
          trophy.position = trophy.position - Vector2(size.x / 30, size.y / 5);
          trophy.angle = 0;
        }
        counter = 1;
      } else {
        // Future.delayed(Duration(milliseconds: 500), () {
        zombie.animation = zombie.dieAnimation;
        zombie.size = Vector2(size.x / 6, size.y / 2.8);
        Future.delayed(Duration(milliseconds: 1600), () {
          remove(zombie);
        });
        // });
        FlameAudio.audioCache
            .play('mixkit-ending-show-audience-clapping-478.wav');
      }
    }
    super.update(dt);
  }
}

class Zombie extends SpriteAnimationComponent with HasGameRef {
  @override
  late final SpriteAnimation runLeftAnimation;
  late final SpriteAnimation dieAnimation;
  late final SpriteAnimation attackAnimation;
  final double _animationSpeed = 0.1;

  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('spritesheet.png'),
      srcSize: Vector2(521.0, 576.0),
    );
    final spriteSheet2 = SpriteSheet(
      image: await gameRef.images.load('spritesheet (2).png'),
      srcSize: Vector2(630.0, 560.0),
    );
    final spriteSheet1 = SpriteSheet(
      image: await gameRef.images.load('spritesheet (1).png'),
      srcSize: Vector2(521.0, 560.0),
    );
    runLeftAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 10);
    animation = runLeftAnimation;
    dieAnimation = spriteSheet2.createAnimation(row: 0, stepTime: 0.15, to: 12);
    attackAnimation =
        spriteSheet1.createAnimation(row: 0, stepTime: 0.15, to: 6);

    size = Vector2(gameRef.size.x / 7.2, gameRef.size.y / 3);
    return super.onLoad();
  }
}
