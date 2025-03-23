import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum PickedImageStatus {
  success,
  canceled,
  error,
  permissionDenied,
}

class PickImageResult {
  final PickedImageStatus status;
  final XFile? file;
  final String? errorMessage;
  final PermissionStatus? permissionStatus;

  PickImageResult._({
    required this.status,
    this.file,
    this.errorMessage,
    this.permissionStatus,
  });

  factory PickImageResult.success(XFile file) {
    return PickImageResult._(
      status: PickedImageStatus.success,
      file: file,
    );
  }

  factory PickImageResult.canceled() {
    return PickImageResult._(status: PickedImageStatus.canceled);
  }

  factory PickImageResult.error(String errorMessage) {
    return PickImageResult._(
      status: PickedImageStatus.error,
      errorMessage: errorMessage,
    );
  }

  factory PickImageResult.permissionDenied(PermissionStatus status) {
    return PickImageResult._(
      status: PickedImageStatus.permissionDenied,
      permissionStatus: status,
    );
  }
}
