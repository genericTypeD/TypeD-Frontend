import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:typed/common/layout/default_layout.dart';

class MyMovieScreen extends ConsumerStatefulWidget {
  final XFile? initialImage;

  const MyMovieScreen({
    this.initialImage,
    super.key,
  });

  @override
  ConsumerState<MyMovieScreen> createState() => _MyMovieScreenState();
}

class _MyMovieScreenState extends ConsumerState<MyMovieScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImageFile;
  final List<XFile> _currentImageFiles = [];

  Future<void> _pickImage() async {
    if (await Permission.storage.request().isGranted) {
      try {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          setState(() {
            _selectedImageFile = image;
            _currentImageFiles.insert(0, image);
          });
        }
      } catch (e) {
        debugPrint('[Picking Image Error] $e');
      }
    }
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
    return const DefaultLayout(child: Column());
  }
}
