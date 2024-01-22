import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/presentation/login/login_screen.dart';
import 'package:pokedex_clean/presentation/login/login_view_model.dart';
import 'package:pokedex_clean/presentation/splash/splash_screen.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';
import 'package:pokedex_clean/presentation/verify/verify_screen.dart';
import 'package:pokedex_clean/presentation/verify/verify_view_model.dart';
import 'package:provider/provider.dart';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => ChangeNotifierProvider(
          create: (_) => getIt<SplashViewModel>(),
          child: const SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => ChangeNotifierProvider(
          create: (_) => getIt<LoginViewModel>(),
          child: const LoginScreen()),
      routes: [
        GoRoute(
            path: 'verify',
            builder: (_, __) => ChangeNotifierProvider(
              create: (_) => getIt<VerifyViewModel>(),
              child: const VerifyScreen(),
            )
        )
      ]
    ),
  ],
);