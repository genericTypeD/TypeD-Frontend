import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:typed/common/component/custom_text_form_field.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_strings.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/provider/auth_provider.dart'; // 추가: auth_provider import
import 'package:typed/common/repository/auth_repository.dart';
import 'package:typed/common/screen/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final AuthRepository authRepository = AuthRepository();
  bool isLoading = false;

  // 로그인 처리 함수
  Future<void> _login(WidgetRef ref) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일과 비밀번호를 입력해주세요'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // AuthProvider를 사용하여 로그인
      final success = await ref.read(authProvider.notifier).login(
            email,
            password,
          );

      if (success && mounted) {
        context.go('/home/type');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인에 실패했습니다'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                // 상단 타이틀
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => context.go('/home/type'),
                      child: Text(
                        'TypeD',
                        style: AppTheme.heading1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                CustomTextFormField(
                  onChanged: (String value) {
                    email = value;
                  },
                  hintText: '이메일을 입력해주세요',
                  labelText: AppStrings.email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  onChanged: (String value) {
                    password = value;
                  },
                  hintText: '비밀번호를 입력해주세요',
                  labelText: AppStrings.password,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '비밀번호를 잊어버리셨나요?',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '비밀번호찾기',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Consumer 위젯을 사용하여 로그인 버튼 구현
                Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: isLoading ? null : () => _login(ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundTertiary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            )
                          : const Text(
                              '로그인',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    '다른 계정으로 로그인',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE500), // 카카오 노란색
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_bubble,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '카카오 계정으로 계속하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: '계정이 없으신가요? ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: '회원가입 하러가기',
                            style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
