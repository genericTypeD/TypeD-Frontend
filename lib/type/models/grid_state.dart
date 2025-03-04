import 'package:typed/type/models/grid_item.dart';

class GridState {
  final List<List<GridItem>> items;

  GridState({required this.items});

  factory GridState.initial() {
    return GridState(
      items: List.generate(
        3,
        (verticalIndex) => List.generate(
          2,
          (horizontalIndex) => GridItem.empty(
            id: 'item_${verticalIndex}_${horizontalIndex}',
          ),
        ),
      ),
    );
  }
}
