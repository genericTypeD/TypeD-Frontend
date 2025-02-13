import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(child: Column());
  }
}
