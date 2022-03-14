import 'package:flame/components.dart';

class World2 extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('level3.g');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
