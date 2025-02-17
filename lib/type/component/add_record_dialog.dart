import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/type/component/grid_text_item.dart';
import 'package:typed/type/screen/screen.dart';

class AddRecordDialog extends StatelessWidget {
  final XFile? initialImage;

  final categories = [
    {'icon': Icons.subject, 'label': '문장', 'route': const MySentenceScreen()},
    {'icon': Icons.book, 'label': '책', 'route': const MyBookScreen()},
    {'icon': Icons.music_note, 'label': '음악', 'route': const MyMusicScreen()},
    {'icon': Icons.movie, 'label': '이미지', 'route': const MyImageScreen()},
  ];

  AddRecordDialog({
    this.initialImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.black,
              width: 0.3,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: categories.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final category = entry.value;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < categories.length - 1 ? 12 : 0,
                  ),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      category['icon'] as IconData,
                      size: 16,
                    ),
                    label: Text(
                      category['label'] as String,
                      style: AppTheme.body1,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xffF3F3F2),
                      overlayColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 22,
                        horizontal: 12,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                          color: Colors.black,
                          width: 0.3,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () async {
                      final result = await Navigator.push<GridItemData>(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            final nextScreen = category['route'] as Widget;
                            if (nextScreen.runtimeType == MyImageScreen) {
                              return MyImageScreen(initialImage: initialImage);
                            } else {
                              return nextScreen;
                            }
                          },
                        ),
                      );

                      if (result != null) {
                        Navigator.pop(context, result);
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
