import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class EndSceneBG extends SpriteAnimationComponent with HasGameRef {
  @override
  late final SpriteAnimation _runDownAnimation;
  final double _animationSpeed = 0.15;

  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('output-onlinegiftools.png'),
      srcSize: Vector2(600.0, 270.0),
    );
    animation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    size = Vector2(gameRef.size.x, gameRef.size.y);
    return super.onLoad();
  }
}
