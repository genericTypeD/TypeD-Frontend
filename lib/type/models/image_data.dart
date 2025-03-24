import 'dart:io';

class ImageData {
  final String? selectedImagePath;
  final List<File> currentImageFiles;

  ImageData({
    this.selectedImagePath,
    this.currentImageFiles = const [],
  });

  ImageData copyWith({
    String? selectedImagePath,
    List<File>? currentImageFiles,
  }) {
    return ImageData(
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      currentImageFiles: currentImageFiles ?? this.currentImageFiles,
    );
  }
}
