import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/app_error.dart';
import '../providers/auth_providers.dart';

class LoginState {
  final bool isLoading;
  final String? error;

  const LoginState({this.isLoading = false, this.error});

  LoginState copyWith({bool? isLoading, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginState> {
  final Ref _ref;

  LoginViewModel(this._ref) : super(const LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = _ref.read(authRepositoryProvider);
      await repository.signInWithEmailAndPassword(email.trim(), password);
      // Başarılı girişte GoRouter redirect mekanizması devreye girecektir.
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AppError(message: 'Giriş başarısız. Lütfen bilgilerinizi kontrol edin.').message,
      );
    }
  }
}

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(ref);
});
