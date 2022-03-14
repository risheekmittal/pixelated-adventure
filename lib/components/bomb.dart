import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';

class Bomb extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  Direction direction = Direction.none;
  bool hasTouched = false;

  Bomb()
      : super(
          size: Vector2(44, 58),
        ) {
    addHitbox(HitboxRectangle());
    anchor = Anchor.center;
    x = 720 / 1.2;
    y = 360 / 2;
  }

  late final SpriteAnimation _explodeAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _fallAnimation;
  final double _animationSpeed = 0.2;

  @override
  Future<void>? onLoad() async {
    _loadAnimations().then((_) => {animation = _fallAnimation});
    return super.onLoad();
  }

  Future<void> _loadAnimations() async {
    final runSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('bomb_walk.png'),
      srcSize: Vector2(64.0, 37.0),
    );
    final explodeSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('bomb_explode.png'),
      srcSize: Vector2(64.0, 55.0),
    );
    final fallSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('bomb_fall.png'),
      srcSize: Vector2(22.0, 29.0),
    );

    _explodeAnimation = explodeSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation = runSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 6);

    _runRightAnimation = runSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 6);
    _fallAnimation = fallSpriteSheet.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    removeHitbox(HitboxRectangle());
    hasTouched = true;
    size = Vector2(140, 130);
    animation = _explodeAnimation;
    Future.delayed(const Duration(milliseconds: 700), () {
      removeFromParent();
    });
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position.add(Vector2(0, dt * 100));
    if (direction == Direction.left) {
      size = Vector2(120, 70);
      animation = _runLeftAnimation;
      position.add(Vector2(-dt * 100, 0));
    } else if (direction == Direction.right) {
      size = Vector2(120, 70);
      animation = _runRightAnimation;
      position.add(Vector2(dt * 100, 0));
    } else if (hasTouched == false) {
      size = Vector2(44, 58);
    }
    if (y > 300) {
      removeFromParent();
    }
    super.update(dt);
  }
}
