import 'package:flutter/material.dart';
import 'package:typed/common/component/custom_text_form_field.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_strings.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/repository/auth_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthRepository authRepository = AuthRepository();

  String email = '';
  String password = '';
  String nickname = '';
  bool isLoading = false;

  Future<void> _signUp() async {
    // 입력값 검증
    if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('모든 필드를 입력해주세요'),
        ),
      );
      return;
    }

    // 이메일 형식 검증
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (!emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('올바른 이메일 형식을 입력해주세요'),
        ),
      );
      return;
    }

    // 비밀번호 길이 검증
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\d~!@#$%^&*()+|=]{8,20}$');
    if (!passwordRegExp.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('비밀번호는 영문+숫자+특수문자를 포함한 8~20자여야 합니다'),
        ),
      );
      return;
    }

    final nicknameRegExp = RegExp(r'^[a-zA-Z가-힣]{2,15}$');
    if (!nicknameRegExp.hasMatch(nickname)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('닉네임은 2~15자 사이의 영문자 또는 한글이어야 합니다'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authRepository.signup(
        email: email,
        password: password,
        nickname: nickname,
      );

      if (mounted) {
        // 회원가입 성공 시 로그인 화면으로 이동
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('회원가입이 완료되었습니다. 로그인해주세요.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().contains('이미 가입된 이메일입니다')
                ? '이미 가입된 이메일입니다'
                : '회원가입 중 오류가 발생했습니다'),
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
                Text(
                  '회원가입',
                  style: AppTheme.heading1,
                ),
                const SizedBox(height: 48),
                CustomTextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (String value) {
                    nickname = value;
                  },
                  hintText: '닉네임을 입력해주세요',
                  labelText: '닉네임',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
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
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading ? null : _signUp,
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
                          '회원가입',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text.rich(
                      TextSpan(
                        text: '이미 계정이 있으신가요? ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        children: const [
                          TextSpan(
                            text: '로그인 하러가기',
                            style: TextStyle(
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
