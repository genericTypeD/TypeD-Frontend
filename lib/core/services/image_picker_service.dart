import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:typed/type/models/picked_image_result.dart';
import 'package:typed/core/services/permission_service.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  final ImagePicker picker = ImagePicker();

  Future<PickImageResult> pickImage() async {
    final permissionStatus = await PermissionService.checkGalleryPermission();

    if (permissionStatus != PermissionStatus.granted) {
      return PickImageResult.permissionDenied(permissionStatus);
    }

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) {
        return PickImageResult.canceled();
      }

      return PickImageResult.success(pickedFile);
    } catch (error) {
      debugPrint('[ImagePickerService 오류] $error');
      return PickImageResult.error('이미지 선택 중 오류가 발생했습니다: $error');
    }
  }

  /// 이미지를 앱 내부 저장소에 저장
  Future<String?> saveImageToAppDirectory(XFile image) async {
    try {
      final pickedImagePath = image.path;
      final pickedImageFile = File(pickedImagePath);

      // 앱 문서 디렉토리
      final directory = await getApplicationDocumentsDirectory();
      final appDirectoryPath = directory.path;

      // 이미지를 저장할 디렉토리 경로
      final imageDirectoryPath = '$appDirectoryPath/images';
      // 디렉토리가 없으면 생성
      await Directory(imageDirectoryPath).create(recursive: true);

      // 저장할 이미지 이름
      final uuid = const Uuid().v4().substring(0, 8);
      final imageName = '${DateTime.now().millisecondsSinceEpoch}_$uuid.png';
      // 저장할 이미지 디렉토리 경로
      final savedImagePath = '$imageDirectoryPath/$imageName';

      // 선택된 이미지를 복사해서 앱 내부 경로에 저장
      final savedImageFile = await pickedImageFile.copy(savedImagePath);

      // 복사된 이미지 파일 저장 성공 여부 확인
      if (await savedImageFile.exists()) {
        debugPrint('[Image Saved Successfully] path: $savedImagePath');
        return savedImagePath;
      } else {
        debugPrint('[복사된 파일이 존재하지 않습니다] path: $savedImagePath');
        return null;
      }
    } catch (error) {
      debugPrint('[이미지 저장 오류] $error');
      return null;
    }
  }
}
