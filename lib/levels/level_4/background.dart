import 'package:flame/components.dart';

class World3 extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('level3.jpg');
    size = Vector2(gameRef.size.x, gameRef.size.y);
    return super.onLoad();
  }
}
