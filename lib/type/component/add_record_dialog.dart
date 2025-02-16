import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/type/screen/screen.dart';

class AddRecordDialog extends StatelessWidget {
  final categories = [
    {'icon': Icons.subject, 'label': '문장', 'route': const MySentenceScreen()},
    {'icon': Icons.book, 'label': '책', 'route': const MyBookScreen()},
    {'icon': Icons.music_note, 'label': '음악', 'route': const MyMusicScreen()},
    {'icon': Icons.movie, 'label': '이미지', 'route': const MyMovieScreen()},
  ];

  AddRecordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundSecondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: const BoxDecoration(
            //color: Colors.white,
            ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  '기록을 추가하세요',
                  style: AppTheme.title1,
                ),
              ),
              const SizedBox(height: 16),
              Column(
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
                        ),
                        label: Text(
                          category['label'] as String,
                          style: AppTheme.body1,
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
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
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return category['route'] as Widget;
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
