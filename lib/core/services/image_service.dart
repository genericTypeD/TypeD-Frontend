import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:typed/core/exceptions/image_exception.dart';

class ImageService {
  /// 경로가 비었는지 확인
  static bool isPathEmpty(String? imagePath) {
    if (imagePath == null) return true;

    final trimmedPath = imagePath.trim();
    return trimmedPath.isEmpty;
  }

  /// 파일 자료형 얻기
  static String getFileExtension(String imagePath) {
    return path.extension(imagePath).toLowerCase();
  }

  /// 이미지 파일인지 확인
  static bool isImageFile(String imagePath) {
    final fileExtension = getFileExtension(imagePath);
    return ['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(fileExtension);
  }

  /// 절대 경로인지 확인
  static bool isAbsolutePath(String imagePath) {
    return path.isAbsolute(imagePath);
  }

  /// image 디렉토리에 속하는지 확인
  static bool isInImageDirectory(String imagePath) {
    return imagePath.startsWith('images/');
  }

  /// 이미지 파일 경로 validation
  static bool isValidImagePath(String? imagePath) {
    if (isPathEmpty(imagePath)) {
      throw EmptyImagePathException();
    }

    if (!isImageFile(imagePath!)) {
      throw InvalidImageFormatException();
    }

    if (path.isAbsolute(imagePath)) {
      throw AbsolutePathException(imagePath);
    }

    if (!isInImageDirectory(imagePath)) {
      throw IncorrectDirectoryException(imagePath);
    }

    return true;
  }

  /// 상대 경로를 절대 경로로 전환
  static Future<String> getAbsolutePath(String relativePath) async {
    if (path.isAbsolute(relativePath)) {
      return relativePath;
    }

    final appDir = await getApplicationDocumentsDirectory();
    return path.join(appDir.path, relativePath);
  }

  /// 절대 경로를 상대 경로로 전환
  static Future<String> getRelativePath(String absolutePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final appDirectoryPath = directory.path;

    final relativePath = absolutePath.replaceFirst('$appDirectoryPath/', '');
    return relativePath;
  }

  /// 앱의 이미지 디렉토리 생성 확인
  static Future<String> ensureImageDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = path.join(appDir.path, 'images');
    final directory = Directory(imagesDir);

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return imagesDir;
  }

  /// 이미지 파일 존재 확인
  static Future<bool> checkImageExists(String? imagePath) async {
    if (isPathEmpty(imagePath)) return false;

    try {
      final absolutePath = await getAbsolutePath(imagePath!);
      final file = File(absolutePath);
      return await file.exists();
    } catch (error) {
      debugPrint('이미지 파일이 존재하는지 확인하는 중 오류가 발생했습니다. $error');
      return false;
    }
  }
}
