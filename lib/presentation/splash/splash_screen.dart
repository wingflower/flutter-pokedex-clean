import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/presentation/routes.dart';
import 'package:pokedex_clean/presentation/splash/login_status.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final SplashViewModel viewModel = context.read();
      _subscription = viewModel.loginStatus.listen((event) {
        switch (event) {
          case LoginStatus.loggedOut:
            context.goNamed(pageLogin);
            FlutterNativeSplash.remove();
          case LoginStatus.loggedIn:
            context.goNamed(pageMain);
            FlutterNativeSplash.remove();
          case LoginStatus.processing:
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    );
  }
}
