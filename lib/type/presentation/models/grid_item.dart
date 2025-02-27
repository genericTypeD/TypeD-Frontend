import 'package:image_picker/image_picker.dart';

class GridItem {
  final String? content;
  final XFile? imageFile;
  final bool isEmpty;

  GridItem({
    this.content,
    this.imageFile,
    String? id,
  }) : isEmpty = content == null && imageFile == null;
}
