import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/authentication/presentation/providers/auth_providers.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home'; // Home feature STAGE 6'da detaylandırılacak
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRouter.splash,
    redirect: (context, state) {
      // Stream henüz yükleniyorsa beklet
      if (authState.isLoading) return null;

      final isAuth = authState.valueOrNull != null;
      final isSplash = state.matchedLocation == AppRouter.splash;
      final isLoggingIn = state.matchedLocation == AppRouter.login;

      // Kullanıcı giriş yapmamışsa ve login ekranında değilse logine yönlendir
      if (!isAuth && !isLoggingIn) {
        return AppRouter.login;
      }

      // Kullanıcı giriş yapmışsa ve splash veya login ekranındaysa ana sayfaya yönlendir
      if (isAuth && (isLoggingIn || isSplash)) {
        return AppRouter.home;
      }

      // Diğer durumlarda rotada kal
      return null;
    },
    routes: [
      GoRoute(
        path: AppRouter.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouter.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouter.home,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen (Stage 6)')),
        ),
      ),
    ],
  );
});
