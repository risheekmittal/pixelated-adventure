import 'package:flame/components.dart';

class World4 extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('level4.jpg');
    size = Vector2(gameRef.size.x, gameRef.size.y);
    return super.onLoad();
  }
}
