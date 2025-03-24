import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/ui/components/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:typed/core/services/image_service.dart';
import 'package:typed/type/viewmodels/image_picker_notifier.dart';
import 'package:typed/type/viewmodels/image_picker_providers.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerState = ref.watch(imagePickerProvider);
    final imagePickerNotifier = ref.read(imagePickerProvider.notifier);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MyRecordLayout(
      onBottomLeftWidgetPressed: () {
        context.pop(null);
      },
      onBottomRightWidgetPressed: () async {
        final imageData = imagePickerState.valueOrNull;
        final selectedImagePath = imageData?.selectedImagePath;

        if (selectedImagePath != null) {
          try {
            final relativePath =
                await ImageService.getRelativePath(selectedImagePath);
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
          child: imagePickerState.when(
            error: (_, __) => _buildErrorScreen(),
            loading: () => _buildLoadingScreen(context),
            data: (imageData) {
              final selectedImagePath = imageData.selectedImagePath;
              final currentImageFiles = imageData.currentImageFiles;

              return Column(
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
                            selectedImagePath != null
                                ? Image.file(
                                    File(selectedImagePath),
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                            GestureDetector(
                              onTap: () async =>
                                  _onGalleryButtonTap(imagePickerNotifier),
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
                        itemCount: currentImageFiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              imagePickerNotifier
                                  .selectImage(currentImageFiles[index].path);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.backgroundSecondary,
                                border: AppBorders.all,
                              ),
                              child: Image.file(
                                currentImageFiles[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onGalleryButtonTap(
    ImagePickerNotifier imagePickerNotifier,
  ) async {
    final result = await imagePickerNotifier.pickImageFromGallery();
    final permissionStatus = result.permissionStatus;

    if (!mounted) return;

    if (permissionStatus == PermissionStatus.denied) {
      _showPermissionDeniedDialog(false);
    }

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showPermissionDeniedDialog(true);
    }
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
          width: screenWidth * 0.75,
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
                style: AppTheme.body2,
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
                          onTap: () async {
                            Navigator.pop(context);

                            var status = await Permission.photos.status;
                            debugPrint('[Permission.photos.status] $status');

                            // if (status.isGranted) {
                            //   debugPrint('📱 [이미 권한 있음]');

                            //   await ref
                            //       .read(imagePickerProvider.notifier)
                            //       .pickImageFromGallery();
                            // }
                            // if (status.isGranted || status.isLimited) {
                            //   debugPrint(
                            //       'status.isGranted || status.isLimited');
                            //   await ref
                            //       .read(imagePickerProvider.notifier)
                            //       .pickImageFromGallery();
                            //   return;
                            // }

                            try {
                              final result = await Permission.photos.request();
                              debugPrint(
                                  '[Permission.photos.request()] $result');
                            } catch (error) {
                              debugPrint('[Permission Request Error] $error');
                            }

                            // if (status.isDenied) {
                            //   debugPrint('📱 [권한 요청 시작]');

                            //   // 권한 요청 다이얼로그
                            //   final result = await Permission.photos.request();
                            //   debugPrint('📱 [권한 요청 결과] $result');

                            //   // 요청 후 권한 상태 다시 확인
                            //   status = await Permission.photos.status;
                            //   debugPrint('📱 [요청 후 상태] $status');
                            // }

                            // // if (isPermanentlyDenied) {
                            // if (status.isPermanentlyDenied) {
                            //   debugPrint('isPermanentlyDenied!!!');
                            //   await openAppSettings();
                            //   // } else {
                            //   //   final result = await Permission.photos.request();
                            //   //   debugPrint('result: $result');

                            //   //   if (result.isGranted) {
                            //   //     if (context.mounted) {
                            //   //       await ref
                            //   //           .read(imagePickerProvider.notifier)
                            //   //           .pickImageFromGallery();
                            //   //     }
                            //   //   }
                            //   // }
                            // }
                            // // } else {
                            // //   // 권한 요청
                            // //   final result = await Permission.photos.request();
                            // //   debugPrint('🔍 권한 요청 결과: $result');

                            // //   if (result.isGranted && context.mounted) {
                            // //     await ref
                            // //         .read(imagePickerProvider.notifier)
                            // //         .pickImageFromGallery();
                            // //   }
                            // // }
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

  Widget _buildErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          CustomPlaceholder(size: 0.1),
          Text(
            '오류가 발생했습니다.\n뒤로 가기를 눌러주세요.',
            style: AppTheme.body1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
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
                  CustomProgressIndicator(),
                  Container(
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
        ),
      ],
    );
  }
}
