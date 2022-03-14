import 'package:flame/components.dart';

class TitleBG extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('13179.jpg');
    size = Vector2(gameRef.size.x, gameRef.size.y);
    return super.onLoad();
  }
}
