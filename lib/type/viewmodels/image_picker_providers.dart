import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/type/models/image_data.dart';
import 'package:typed/core/services/image_picker_service.dart';
import 'package:typed/type/viewmodels/image_picker_notifier.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return ImagePickerService();
});

final imagePickerProvider =
    StateNotifierProvider<ImagePickerNotifier, AsyncValue<ImageData>>((ref) {
  final service = ref.watch(imagePickerServiceProvider);
  return ImagePickerNotifier(service);
});
