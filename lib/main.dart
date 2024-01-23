import 'package:firebase_core/firebase_core.dart'  hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:pokedex_clean/di/di_setup.dart';
import 'package:pokedex_clean/firebase_options.dart';
import 'package:pokedex_clean/presentation/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  diSetup();

  runApp(const MyApp());
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
