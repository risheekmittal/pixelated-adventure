import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';

class Dino extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  Direction direction = Direction.none;
  bool hasTouched = false;
  bool isFall = false;

  Dino()
      : super(
          size: Vector2(44, 58),
        ) {
    addHitbox(HitboxRectangle());
    anchor = Anchor.center;
    x = 720 / 2;
    y = 360 / 2;
  }

  late final SpriteAnimation _kickAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _stillAnimation;
  final double _animationSpeed = 0.1;

  @override
  Future<void>? onLoad() async {
    _loadAnimations().then((_) => {animation = _stillAnimation});
    return super.onLoad();
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('doux.png'),
      srcSize: Vector2(24.0, 24.0),
    );
    final leftSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('doux-left.png'),
      srcSize: Vector2(24.0, 24.0),
    );

    _kickAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, from: 13, to: 18);

    _runLeftAnimation = leftSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, from: 14, to: 20);

    _runRightAnimation = spriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, from: 5, to: 11);
    _stillAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 5);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    isFall = true;
    print(isFall);
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
  }

  @override
  void update(double dt) {
    if (x > gameRef.size.x / 1.5) {
      if (x > gameRef.size.x / 1.4) {
        print('yessss');
        if (direction == Direction.right) {
          direction = Direction.none;
        } else if (direction == Direction.left) {
          animation = _runLeftAnimation;
          position.add(Vector2(-dt * 100, 0));
        } else if (hasTouched == false) {
          animation = _stillAnimation;
        }
      } else {
        if (direction == Direction.left) {
          animation = _runLeftAnimation;
          position.add(Vector2(-dt * 100, 0));
        } else if (direction == Direction.right) {
          animation = _runRightAnimation;
          position.add(Vector2(dt * 100, 0));
        } else if (hasTouched == false) {
          animation = _stillAnimation;
        }
      }
      if (y < 280) {
        if (direction == Direction.down) {
          position.add(Vector2(0, dt * 100));
        }
      }
      if (y > 70) {
        if (direction == Direction.up) {
          position.add(Vector2(0, dt * -100));
        }
      }
    } else {
      if (75 < y && y < 180 && isFall) {
        position.add(Vector2(0, dt * 100));
      } else if (185 < y && y < 280 && isFall) {
        position.add(Vector2(0, dt * 100));
      }
      if (y == 70 || y == 180 || y == 280) {
        isFall = false;
        print(isFall);
      }
      if (x < gameRef.size.x / 11) {
        print('yessss');
        if (direction == Direction.right) {
          animation = _runRightAnimation;
          position.add(Vector2(dt * 100, 0));
        } else if (direction == Direction.left) {
          direction = Direction.none;
        } else if (hasTouched == false) {
          animation = _stillAnimation;
        }
      } else {
        if (direction == Direction.left) {
          animation = _runLeftAnimation;
          position.add(Vector2(-dt * 100, 0));
        } else if (direction == Direction.right) {
          animation = _runRightAnimation;
          position.add(Vector2(dt * 100, 0));
        } else if (hasTouched == false) {
          animation = _stillAnimation;
        }
      }
    }
    super.update(dt);
  }
}

class Bridge extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  Vector2 pos;
  Bridge(this.pos);
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('bridge.png');
    size = Vector2(500, 32);
    position = pos;
    return super.onLoad();
  }
}

class Water extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('water.png');
    size = Vector2(720, 32);
    position = Vector2(0, gameRef.size.y / 1.1);
    return super.onLoad();
  }
}

class Ladder extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  Ladder(Sprite sprite) : super(sprite: sprite);
  @override
  Future<void>? onLoad() async {
    size = Vector2(80, 300);
    position = Vector2(gameRef.size.x / 1.5, gameRef.size.y / 50);
    return super.onLoad();
  }
}
