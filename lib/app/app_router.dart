import 'package:go_router/go_router.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}
