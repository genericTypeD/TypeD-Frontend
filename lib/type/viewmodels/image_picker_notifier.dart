import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/type/models/image_data.dart';
import 'package:typed/type/models/picked_image_result.dart';
import 'package:typed/core/services/image_picker_service.dart';

class ImagePickerNotifier extends StateNotifier<AsyncValue<ImageData>> {
  final ImagePickerService _service;

  ImagePickerNotifier(this._service) : super(AsyncValue.data(ImageData()));

  Future<PickImageResult> pickImageFromGallery() async {
    debugPrint('pickImageFromGallery()');
    state = AsyncValue.loading();

    try {
      final pickedImageResult = await _service.pickImage();
      debugPrint('pickedImageResult.status: ${pickedImageResult.status}');

      if (pickedImageResult.status == PickedImageStatus.permissionDenied ||
          pickedImageResult.status == PickedImageStatus.canceled) {
        final currentData = state.valueOrNull ?? ImageData();
        state = AsyncValue.data(currentData);
        return pickedImageResult;
      }

      if (pickedImageResult.status == PickedImageStatus.error) {
        state = AsyncValue.error(
          pickedImageResult.errorMessage ?? 'Image Picker Error',
          StackTrace.current,
        );
        return pickedImageResult;
      }

      if (pickedImageResult.file == null) {
        state = AsyncValue.error(
          pickedImageResult.errorMessage ?? 'Picked Image File is Empty',
          StackTrace.current,
        );
        return pickedImageResult;
      }

      final pickedImageResultFile = pickedImageResult.file!;
      final savedImagePath =
          await _service.saveImageToAppDirectory(pickedImageResultFile);

      if (savedImagePath == null) {
        state = AsyncValue.error(
          '이미지 저장에 실패했습니다',
          StackTrace.current,
        );
        return PickImageResult.error('이미지 저장에 실패했습니다');
      }

      final currentData = state.valueOrNull ?? ImageData();
      final savedImageFile = File(savedImagePath);

      final currentImageFiles = List<File>.from(currentData.currentImageFiles)
        ..insert(0, savedImageFile);

      state = AsyncValue.data(
        currentData.copyWith(
          selectedImagePath: savedImagePath,
          currentImageFiles: currentImageFiles,
        ),
      );
      return PickImageResult.success(pickedImageResultFile);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return PickImageResult.error(error.toString());
    }
  }

  void selectImage(String imagePath) {
    state.whenData((data) {
      state = AsyncValue.data(data.copyWith(selectedImagePath: imagePath));
    });
  }
}
