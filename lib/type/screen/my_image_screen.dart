import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:typed/common/const/app_bar_style.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';
import 'package:typed/type/component/grid_text_item.dart';

class MyImageScreen extends ConsumerStatefulWidget {
  final XFile? initialImage;

  const MyImageScreen({
    this.initialImage,
    super.key,
  });

  @override
  ConsumerState<MyImageScreen> createState() => _MyMovieScreenState();
}

class _MyMovieScreenState extends ConsumerState<MyImageScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImageFile;
  final List<XFile> _currentImageFiles = [];

  Future<void> _pickImage() async {
    if (await _checkGalleryPermission()) {
      try {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          setState(
            () {
              _selectedImageFile = image;
              // // TODO: - 이미지 중복 체크
              _currentImageFiles.insert(0, image);
            },
          );
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

  @override
  void initState() {
    super.initState();

    if (widget.initialImage != null) {
      _selectedImageFile = widget.initialImage!;
      _currentImageFiles.add(widget.initialImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: const Text(
            '뒤로 가기',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        bottomRightWidget: TextButton(
          onPressed: _selectedImageFile != null
              ? () {
                  final result = GridItemData(
                    imageFile: _selectedImageFile,
                  );
                  Navigator.pop(context, result);
                }
              : null,
          child: const Text(
            '기록',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppBarStyle.borderContainerWidth,
            decoration: const BoxDecoration(
              color: Color(0xffF3F3F2),
              border: Border(right: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffF3F3F2),
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: AppBarStyle.borderStyle),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 0.3,
                              ),
                            ),
                            child: Stack(
                              children: [
                                _selectedImageFile != null
                                    ? Image.file(
                                        File(
                                          _selectedImageFile!.path,
                                        ),
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(),
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffF3F3F2),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        right: BorderSide(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        'assets/images/grid_item_placeholder.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.06,
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
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 0.3,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: screenHeight * 0.16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _currentImageFiles.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImageFile =
                                        _currentImageFiles[index];
                                  });
                                },
                                // onDoubleTap: () {
                                //   setState(() {
                                //     _currentImageFiles
                                //         .remove(_currentImageFiles[index]);
                                //   });
                                // },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF3F3F2),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.3,
                                    ),
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
            ),
          ),
          Container(
            width: AppBarStyle.borderContainerWidth,
            decoration: const BoxDecoration(
              color: Color(0xffF3F3F2),
              border: Border(left: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
