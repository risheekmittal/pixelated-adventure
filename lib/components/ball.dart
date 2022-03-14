import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_slider_puzzle/levels/level_2/level_2.dart';

class Platform extends SpriteComponent with HasGameRef, Draggable {
  Vector2? dragPosition;
  @override
  Future<void>? onLoad() async {
    final imageDown = await gameRef.images.load('buttons.png');
    final sheet2 = SpriteSheet.fromColumnsAndRows(
      image: imageDown,
      columns: 2,
      rows: 3,
    );
    sprite = sheet2.getSpriteById(0);
    size = Vector2(20, 150);
    position = Vector2(gameRef.size.x / 1.1, gameRef.size.y / 2);
    return super.onLoad();
  }

  @override
  bool onDragStart(int pointerId, DragStartInfo info) {
    dragPosition = info.eventPosition.game - Vector2(x, y);
    return false;
  }

  @override
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    if (parent is! Level2) {
      return true;
    }
    final dragPosition = this.dragPosition;
    if (dragPosition == null) {
      return false;
    }

    position.setFrom(info.eventPosition.game - dragPosition);
    return false;
  }

  @override
  bool onDragEnd(int pointerId, DragEndInfo info) {
    dragPosition = null;
    return false;
  }

  @override
  bool onDragCancel(int pointerId) {
    dragPosition = null;
    return false;
  }
}
