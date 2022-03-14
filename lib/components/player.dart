import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_slider_puzzle/helpers/direction.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, HasHitboxes, Collidable {
  Player()
      : super(
          size: Vector2.all(30.0),
        ) {
    addHitbox(HitboxRectangle());
    anchor = Anchor.center;
    x = 360 / 2;
    y = 720 / 2;
  }

  double playerSpeed = 150.0;
  Direction direction = Direction.none;
  Direction collisionDirection = Direction.none;
  bool hasCollided = false;
  bool collision = false;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;
  SpriteComponent character = SpriteComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) async {
    super.onCollision(intersectionPoints, other);
    if (!hasCollided) {
      hasCollided = true;
      collisionDirection = direction;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    hasCollided = false;
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * playerSpeed));
  }

  void moveUp(double delta) {
    position.add(Vector2(0, -delta * playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(-delta * playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * playerSpeed, 0));
  }

  bool canPlayerMoveUp() {
    if (hasCollided && collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (hasCollided && collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (hasCollided && collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (hasCollided && collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }
}
