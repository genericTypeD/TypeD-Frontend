import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:typed/core/services/image_service.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:uuid/uuid.dart';

class MyImageRecordScreen extends ConsumerStatefulWidget {
  final GridItem? item;

  const MyImageRecordScreen({
    this.item,
    super.key,
  });

  @override
  ConsumerState<MyImageRecordScreen> createState() => _MyImageScreenState();
}

class _MyImageScreenState extends ConsumerState<MyImageRecordScreen> {
  final ImagePicker _picker = ImagePicker();

  String? _selectedImagePath;
  final List<File> _currentImageFiles = [];

  Future<void> _pickImage() async {
    if (await _checkGalleryPermission()) {
      try {
        final pickedImage =
            await _picker.pickImage(source: ImageSource.gallery);

        if (pickedImage != null) {
          final pickedImagePath = pickedImage.path;
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
          final imageName =
              '${DateTime.now().millisecondsSinceEpoch}_$uuid.png';
          // 저장할 이미지 디렉토리 경로
          final savedImagePath = '$imageDirectoryPath/$imageName';

          // 선택된 이미지를 복사해서 앱 내부 경로에 저장
          final savedImageFile = await pickedImageFile.copy(savedImagePath);

          // 복사된 이미지 파일 저장 성공 여부(앱 내부 디렉토리에 존재 여부) 확인
          if (await savedImageFile.exists()) {
            debugPrint('[Image Saved Successfully] path: $savedImagePath');

            setState(
              () {
                _selectedImagePath = savedImagePath;
                _currentImageFiles.insert(0, savedImageFile);
              },
            );
          } else {
            debugPrint(
                '[Image Saved Failed(Error: 복사된 파일이 존재하지 않습니다)] path: $savedImagePath');
            return;
          }
        }
      } catch (e) {
        debugPrint('[Picking Image Error] $e');
      }
    }
  }

  Future<bool> _checkGalleryPermission() async {
    final status = await Permission.storage.status;

    debugPrint('[status]: ${status.name}');

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog(true);
      return false;
    }

    final result = await Permission.photos.request();
    if (!result.isGranted) {
      _showPermissionDeniedDialog(false);
      return false;
    }

    return true;
  }

  void _showPermissionDeniedDialog(bool isPermanentlyDenied) {
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        shape: Border.all(
          color: Colors.black,
          width: 0.3,
        ),
        child: SizedBox(
          width: screenWidth * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                '갤러리 접근 권한',
                style: AppTheme.title2,
              ),
              const SizedBox(height: 8),
              Text(
                isPermanentlyDenied
                    ? '설정에서 갤러리 접근 권한을 허용해주세요.'
                    : '갤러리 접근 권한이 필요합니다.',
                style: AppTheme.body3,
              ),
              const SizedBox(height: 16),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F3F2),
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 0.3,
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              ),
                              color: Color(0xFFF3F3F2),
                            ),
                            child: Center(
                              child: Text(
                                '취소',
                                style: AppTheme.title3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            if (isPermanentlyDenied) {
                              openAppSettings();
                            } else {
                              Permission.photos.request();
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3F3F2),
                            ),
                            child: Center(
                              child: Text(
                                isPermanentlyDenied ? '설정으로 이동' : '권한 허용',
                                style: AppTheme.title3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MyRecordLayout(
      onBottomLeftWidgetPressed: () {
        context.pop(null);
      },
      onBottomRightWidgetPressed: () async {
        if (_selectedImagePath != null) {
          try {
            final relativePath =
                await ImageService.getRelativePath(_selectedImagePath!);
            final result = GridItem.image(
              id: Uuid().v4(),
              imagePath: relativePath,
            );

            if (context.mounted) {
              context.pop(result);
            }
          } catch (error) {
            if (context.mounted) {
              debugPrint('[이미지 저장 오류] $error');
              _buildSnackBar('이미지 저장 중 오류가 발생했습니다');
            }
          }
        } else {
          if (context.mounted) {
            _buildSnackBar('이미지를 선택해주세요');
          }
        }
      },
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: AppBarStyle.borderStyle,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppSpacings.spacing16,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: AppBorders.all,
                    ),
                    child: Stack(
                      children: [
                        _selectedImagePath != null
                            ? Image.file(
                                File(_selectedImagePath!),
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                            decoration: const BoxDecoration(
                              color: AppColors.backgroundSecondary,
                              border: AppBorders.bottomRight,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppSpacings.spacing8,
                              ),
                              child: CustomPlaceholder(
                                size: 0.06,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: AppBorders.top,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppSpacings.spacing16,
                  ),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: screenHeight * 0.16,
                      mainAxisSpacing: AppSpacings.spacing16,
                    ),
                    itemCount: _currentImageFiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImagePath = _currentImageFiles[index].path;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundSecondary,
                            border: AppBorders.all,
                          ),
                          child: Image.file(
                            File(_currentImageFiles[index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: AppTheme.body3.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.backgroundQuaternary,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
