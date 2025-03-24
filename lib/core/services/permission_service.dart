import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// 갤러리 권한 체크
  static Future<PermissionStatus> checkGalleryPermission() async {
    debugPrint('checkGalleryPermission()');
    final status = await Permission.photos.status;
    debugPrint('[Permission.photos.status] $status');

    if (status.isGranted) {
      return PermissionStatus.granted;
    } else if (status.isPermanentlyDenied) {
      return PermissionStatus.permanentlyDenied; // 권한 거부 다이얼로그 표시용
    } else {
      return PermissionStatus.denied; // 권한 거부 다이얼로그 표시용
    }
  }
}
