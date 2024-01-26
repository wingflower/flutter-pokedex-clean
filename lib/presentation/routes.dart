import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/presentation/detail_screen/detail_screen.dart';
import 'package:pokedex_clean/presentation/login/login_screen.dart';
import 'package:pokedex_clean/presentation/login/login_view_model.dart';
import 'package:pokedex_clean/presentation/main/main_screen.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:pokedex_clean/presentation/roulette/roulette_screen.dart';
import 'package:pokedex_clean/presentation/splash/splash_screen.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

const pageSplash = ' splash';
const pageLogin = ' login';
const pageMain = ' main';
const pageRoulette = ' roulette';
const pageDetail = ' detail';

final routes = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: pageSplash,
      builder: (_, __) => ChangeNotifierProvider(create: (_) => getIt<SplashViewModel>(), child: const SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      name: pageLogin,
      builder: (_, __) => ChangeNotifierProvider(create: (_) => getIt<LoginViewModel>(), child: const LoginScreen()),
    ),
    GoRoute(
      path: '/main',
      name: pageMain,
      builder: (_, __) => ChangeNotifierProvider(
        create: (_) => getIt<MainViewModel>(),
        child: const MainScreen(),
      ),
      routes: [
        GoRoute(
          path: 'roulette',
          name: pageRoulette,
          builder: (_, __) => const RouletteScreen(),
        ),
        GoRoute(
          path: 'detail',
          name: pageDetail,
          builder: (_, __) => const DetailScreen(),
        ),
      ],
    ),
  ],
);
