import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/presentation/common.dart';
import 'package:pokedex_clean/presentation/login/login_ui_event.dart';
import 'package:pokedex_clean/presentation/login/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();

  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final LoginViewModel viewModel = context.read();
      _subscription = viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            showSnackBar(context, event.message);
          case SuccessLogin():
            context.go('/main');
          case SuccessRegister():
            context.push('/login/verify');
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = context.watch();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email'
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: () {
                viewModel.registerEmailAndPassword(_emailController.text, _passwordController.text);
              }, child: const Text('Register')),
              TextButton(onPressed: () {
                viewModel.signInEmailAndPassword(_emailController.text, _passwordController.text);
              }, child: const Text('LogIn')),
            ],
          )
        ],
      )
    );
  }
}
