import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/presentation/splash/splash_screen.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';
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
  ],
);