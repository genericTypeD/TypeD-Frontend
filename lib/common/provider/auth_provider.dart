// lib/common/provider/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:typed/common/repository/auth_repository.dart';

// 로그인 상태를 나타내는 클래스
class AuthState {
  final bool isLoggedIn;
  final String? accessToken;
  final String? nickname;
  final int? memberId;

  AuthState({
    required this.isLoggedIn,
    this.accessToken,
    this.nickname,
    this.memberId,
  });

  factory AuthState.loggedOut() => AuthState(isLoggedIn: false);

  factory AuthState.loggedIn(
          {required String accessToken,
          required String nickname,
          required int memberId}) =>
      AuthState(
        isLoggedIn: true,
        accessToken: accessToken,
        nickname: nickname,
        memberId: memberId,
      );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.loggedOut()) {
    _checkLoginStatus(); // 초기 로그인 상태 확인
  }

  Future<void> _checkLoginStatus() async {
    final token = await _repository.storage.read(key: 'ACCESS_TOKEN');
    final nickname = await _repository.storage.read(key: 'USER_NICKNAME');
    final memberIdStr = await _repository.storage.read(key: 'USER_ID');

    if (token != null && nickname != null && memberIdStr != null) {
      final memberId = int.tryParse(memberIdStr) ?? 0;
      state = AuthState.loggedIn(
        accessToken: token,
        nickname: nickname,
        memberId: memberId,
      );
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final token = await _repository.login(email: email, password: password);
      // storage에서 가져온 사용자 정보
      final nickname = await _repository.storage.read(key: 'USER_NICKNAME');
      final memberIdStr = await _repository.storage.read(key: 'USER_ID');
      final memberId = int.tryParse(memberIdStr ?? '0') ?? 0;

      state = AuthState.loggedIn(
        accessToken: token,
        nickname: nickname ?? '',
        memberId: memberId,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState.loggedOut();
  }
}

// Provider 선언
final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
