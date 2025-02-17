import 'package:flutter/material.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';

class SentenceInput extends StatefulWidget {
  const SentenceInput({super.key});

  @override
  State<SentenceInput> createState() => _SentenceInputState();
}

class _SentenceInputState extends State<SentenceInput>
    with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardVisible = false;
  bool _isPrivate = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary, // ✅ 기존 컬러 유지
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close,
            size: 24.0,
            color: Colors.black,
          ),
        ),
        title: Text(
          "문장 수집",
          style: AppTheme.title2,
        ),
        actions: [
          TextButton(
            onPressed: () {
              print("완료 버튼 클릭됨");
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            child: Text(
              "완료",
              style: AppTheme.title3,
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 화면 터치하면 키보드 닫힘
        },
        child: Container(
          color: AppColors.backgroundSecondary,
          child: Stack(
            children: [
              // 키보드가 보일 때만 문구 숨기기
              AnimatedOpacity(
                opacity: _isKeyboardVisible ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 80.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "수집한 문장이\n내일을 바꿀지 몰라요",
                      style: AppTheme.title2,
                    ),
                  ),
                ),
              ),
              // TextField 위치 조정 (포커스 시 앱바 아래 20px)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: _isKeyboardVisible ? 20.0 : 160.0, // 포커스 시 앱바 20px 아래로 이동
                left: 16.0,
                right: 16.0,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _controller,
                        cursorHeight: 20.0,
                        autofocus: false,
                        maxLines: 8,
                        keyboardType: TextInputType.multiline,
                        style: AppTheme.body1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
                          hintText: "예) 감명 깊은 문장을 입력해 보세요.",
                          hintStyle: AppTheme.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: AppColors.borderBlack,
                              width: 0.3, // 기본 상태의 테두리 유지
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: AppColors.borderBlack,
                              width: 0.3, // 포커스되지 않은 상태에서도 같은 테두리 유지
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: AppColors.borderBlack,
                              width: 0.3, // 포커스 상태에서도 같은 두께 유지
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0), // TextField와 토글 간 간격
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isPrivate = !_isPrivate;
                          });
                        },
                        icon: Icon(
                          _isPrivate ? Icons.lock_outline : Icons.public,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        label: Text(
                          _isPrivate ? "비공개" : "공개",
                          style: AppTheme.body2.copyWith(
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
