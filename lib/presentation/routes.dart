import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/login/login_screen.dart';
import 'package:pokedex_clean/presentation/login/login_view_model.dart';
import 'package:pokedex_clean/presentation/main/detail_screen/detail_screen.dart';
import 'package:pokedex_clean/presentation/main/main_screen.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_screen.dart';
import 'package:pokedex_clean/presentation/splash/splash_screen.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, __) => ChangeNotifierProvider(
          create: (_) => getIt<SplashViewModel>(), child: const SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => ChangeNotifierProvider(
          create: (_) => getIt<LoginViewModel>(), child: const LoginScreen()),
    ),
    GoRoute(
      path: '/main',
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<MainViewModel>(),
        child: const MainScreen(),
      ),
      routes: [
        GoRoute(
          path: 'roulette',
          builder: (_, __) => const RouletteScreen(),
        ),
        GoRoute(
          path: 'detail',
          builder: (_, state) {
            return DetailScreen(
              pokemonData: state.extra! as Pokemon,
            );
          },
        ),
      ],
    ),
  ],
);
