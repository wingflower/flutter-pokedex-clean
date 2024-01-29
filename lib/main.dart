import 'package:firebase_core/firebase_core.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/firebase_options.dart';
import 'package:pokedex_clean/presentation/routes.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_clean/app_timer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  diSetup();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppTimer(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
      title: 'Pokedex Clean',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
