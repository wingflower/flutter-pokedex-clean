import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/core/assets.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
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

  final FocusNode _passwordFocusNode = FocusNode();

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
            context.push(
              '/login/verify',
              extra: EmailPassword(email: _emailController.text, password: _passwordController.text),
            );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _subscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final LoginViewModel viewModel = context.watch();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(loginBackground,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: height / 4, horizontal: 16.0),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(32.0)),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: '이메일',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: '비밀번호', prefixIcon: Icon(Icons.password_outlined)),
                  obscureText: true,
                  focusNode: _passwordFocusNode,
                  onSubmitted: (_) => viewModel.signInEmailAndPassword(_emailController.text, _passwordController.text),
                ),
                const SizedBox(height: 64.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: viewModel.isLoading ? null
                        : () => viewModel.registerEmailAndPassword(_emailController.text, _passwordController.text),
                      child: const Text('회원가입',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 18
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.isLoading ? null
                        : () => viewModel.signInEmailAndPassword(_emailController.text, _passwordController.text),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: viewModel.isLoading ? null
                    : () => context.push('/login/reset_password', extra: _emailController.text),
                  child: const Text('비밀번호 초기화',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
