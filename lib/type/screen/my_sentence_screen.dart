import 'package:flutter/material.dart';
import 'package:typed/common/const/app_bar_style.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/index.dart';
import 'package:typed/type/component/grid_text_item.dart';

class MySentenceScreen extends StatefulWidget {
  final String? initialText;

  const MySentenceScreen({
    this.initialText,
    super.key,
  });

  @override
  State<MySentenceScreen> createState() => _MySentenceScreenState();
}

class _MySentenceScreenState extends State<MySentenceScreen> {
  final TextEditingController _textController = TextEditingController();

  String? _selectedText;
  List<String> _currentTexts = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialText != null) {
      _selectedText = widget.initialText;
      _currentTexts.add(widget.initialText!);
      _textController.text = widget.initialText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: const Color(0xffF3F3F2),
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
          onPressed: () {
          },
          child: const Text(
            '기록하기',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
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
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width:
                                  MediaQuery.of(context).size.width * 0.9 - 64,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.3,
                                ),
                              ),
                              child: TextField(
                                // TODO: - width, height, drag할 때 색상
                                maxLines: null,
                                controller: _textController,
                                style: AppTheme.body2.copyWith(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  hintText: '문장을 입력하세요',
                                  hintStyle: AppTheme.body2.copyWith(
                                    color: Colors.black,
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  border: InputBorder.none,
                                ),
                                onTapOutside: (event) =>
                                    FocusScope.of(context).unfocus(),
                                onSubmitted: (value) {
                                  debugPrint('onSubmitted value: ${value}');
                                  // if (value.isNotEmpty) {
                                  //   setState(() {
                                  //     _selectedText = value;
                                  //     _currentTexts.insert(0, value);
                                  //     _textController.clear();
                                  //   });
                                  // }
                                  // if (_textController.text.isNotEmpty) {
                                  //   final _trimmedText =
                                  //       _textController.text.trim();
                                  //   setState(() {
                                  //     _currentTexts.insert(
                                  //       0,
                                  //       _trimmedText,
                                  //     );
                                  //   });
                                  // }
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _textController.clear();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF3F3F2),
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                          top: BorderSide(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.clear,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF3F3F2),
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                          top: BorderSide(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.asset(
                                          'assets/images/grid_item_placeholder.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 0.3,
                              ),
                            ),
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: _currentTexts.length,
                              itemBuilder: (context, index) {
                                final text = _currentTexts[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedText = text;
                                      _textController.text = text;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: index != _currentTexts.length - 1
                                          ? const Border(
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 0.3,
                                              ),
                                            )
                                          : null,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      text,
                                      style: AppTheme.body3.copyWith(
                                        color: Colors.black,
                                      ),
                                      maxLines: null,
                                    ),
                                  ),
                                );
                              },
                            ),
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

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
