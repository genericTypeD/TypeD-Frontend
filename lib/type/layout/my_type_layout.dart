import 'package:flutter/material.dart';
import 'package:typed/common/const/app_themes.dart';

class MyTypeLayout extends StatefulWidget {
  final String screenTheme;

  const MyTypeLayout({required this.screenTheme, super.key});

  @override
  State<MyTypeLayout> createState() => _MyTypeLayoutState();
}

class _MyTypeLayoutState extends State<MyTypeLayout> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '좋아하는 ${widget.screenTheme}',
          style: AppTheme.title1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              style: AppTheme.body1,
              decoration: InputDecoration(
                hintText: '올해의 ${widget.screenTheme}을 입력하세요.',
                hintStyle: AppTheme.body1,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                overlayColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              child: Text(
                '저장하기',
                style: AppTheme.body1,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
