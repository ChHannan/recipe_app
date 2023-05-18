import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/repositories/auth_repository.dart';

final loginViewProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, AsyncValue<User?>>((ref) {
  return LoginViewModel(
    authRepository: ref.watch(authRepoProvider),
  );
});

class LoginViewModel extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository authRepository;

  LoginViewModel({
    required this.authRepository,
  }) : super(const AsyncValue.data(null));

  /// Login preregistered user
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = const AsyncValue.loading();
      UserCredential user = await authRepository.login(
        email: email,
        password: password,
      );
      state = AsyncValue.data(user.user);
    } catch (err, trace) {
      state = AsyncValue.error(err, trace);
    }
  }
}
