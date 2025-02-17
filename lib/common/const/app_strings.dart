class AppStrings {
  const AppStrings._();

  static const String PageNotFound = '페이지를 찾을 수 없습니다';

  static const String register = '회원가입';
  static const String login = '로그인';
  static const String signInToYourAccount = '로그인 해주세요';

  static const String forgetPassword = '비밀번호를 잊어버리셨나요?';
  static const String findPassword = '비밀번호 찾기';

  static const String doNotHaveAnAccount = "계정이 없으신가요?";
  static const String createYourAccount = '회원가입 하러가기';

  static const String orLoginWith = '다른 계정으로 로그인';
  static const String kakaotalkLogin = '카카오 계정으로 계속하기';
  static const String appleLogin = '애플 계정으로 계속하기';
  static const String googleLogin = '구글 계정으로 계속하기';

  static const String nickname = '닉네임';
  static const String pleaseEnterNickname = '닉네임을 입력해주세요';
  static const String invalidNickname = '유효하지 않는 닉네임';

  static const String email = '이메일';
  static const String pleaseEnterEmailAddress = '이메일을 입력해주세요.';
  static const String invalidEmailAddress = '유효하지 않는 이메일입니다.';

  static const String password = '비밀번호';
  static const String pleaseEnterPassword = '비밀번호를 입력해주세요.';
  static const String invalidPassword = '유효하지 않는 비밀번호입니다.';

  static const galleryPermission = _GalleryPermission();
  static const appBar = _AppBar();
}

/// 갤러리 권한 관련 GalleryPermission Strings
class _GalleryPermission {
  const _GalleryPermission();

  final title = '갤러리 접근 권한';
  final bodyIfPermanetlyDenied = '설정에서 갤러리 접근 권한을 허용해주세요.';
  final bodyInitially = '갤러리 접근 권한이 필요합니다.';

  final cancelButton = '취소';
  final acceptButtonIfPermanetlyDenied = '설정으로 이동';
  final acceptButtonInitially = '권한 허용';
}

/// 앱바 관련 AppBar Strings
class _AppBar {
  const _AppBar();

  final backButton = '뒤로 가기';
  final saveButton = '기록';
}
