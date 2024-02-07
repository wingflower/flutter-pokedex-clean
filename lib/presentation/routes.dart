import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/presentation/login/login_screen.dart';
import 'package:pokedex_clean/presentation/login/login_view_model.dart';
import 'package:pokedex_clean/presentation/main/detail_screen/detail_screen.dart';
import 'package:pokedex_clean/presentation/main/detail_screen/type/type_screen.dart';
import 'package:pokedex_clean/presentation/main/main_screen.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_screen.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_view_model.dart';
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
      builder: (_, __) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => getIt<MainViewModel>(),
          ),
          ChangeNotifierProvider(
            create: (_) => getIt<AppTimer>(),
          )
        ],
        builder: (_, __) => const MainScreen(),
      ),
      routes: [
        GoRoute(
          path: 'roulette',
          builder: (_, state) {
            final map = state.extra! as Map<String, dynamic>;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: (map['parentContext'] as BuildContext).read<AppTimer>(),
                ),
                ChangeNotifierProvider(
                  create: (_) => getIt<RouletteViewModel>(),
                ),
              ],
              child: RouletteScreen(
                pokemonList: map['pokemonData'] as List<Pokemon>,
                userInfo: map['userInfo'] as UserInfo,
                email: map['email'] as String,
              ),
            );
          },
        ),
        GoRoute(
          path: 'detail',
          builder: (_, state) {
            if (state.extra != null) {
              Map<String, dynamic> args = state.extra! as Map<String, dynamic>;
              return DetailScreen(
                pokemonData: args['pokemonList'],
                mainState: args['mainState'],
              );
            } else {
              return const MainScreen();
            }
          },
        ),
        GoRoute(
          path: 'type',
          builder: (_, state) {
            return TypeScreen(typeList: state.extra! as List<TypeModel>);
          },
        ),
      ],
    ),
  ],
);
