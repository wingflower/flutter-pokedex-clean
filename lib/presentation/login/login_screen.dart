import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/core/assets.dart';
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

  final PageController _pageController = PageController(initialPage: 1);

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
            _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
            viewModel.sendVerifyEmail();
          case SuccessVerify():
            context.go('/main');
          case SuccessResetPassword():
            showSimpleDialog(
              context,
              cancelable: false,
              isVisibleCancelButton: false,
              title: '비밀번호 재설정',
              content: '${_emailController.text} 주소로 비밀번호 재설정 메일을 전송하였습니다\n메일함을 확인하여 비밀번호를 재설정하세요.',
              confirmAction: () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
            );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _passwordFocusNode.dispose();
    _subscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _pageResetPassword(),
                _pageLogin(),
                _pageVerify(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageLogin() {
    final LoginViewModel viewModel = context.watch();
    return Column(
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
              : () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
          child: const Text('비밀번호 초기화',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _pageResetPassword() {
    final LoginViewModel viewModel = context.watch();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: viewModel.isLoading ? null
                  : () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
              icon: const Icon(Icons.arrow_forward_outlined),
              label: const Text('돌아가기',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: '이메일',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          textInputAction: TextInputAction.done,
          //onSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
        ),
        const SizedBox(height: 32),
        TextButton(
          onPressed: viewModel.isLoading ? null
              : () => viewModel.resetPassword(_emailController.text),
          child: const Text(
            '비밀번호 재설정',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _pageVerify() {
    final LoginViewModel viewModel = context.watch();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: viewModel.isLoading ? null
                  : () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
              icon: const Icon(Icons.arrow_back_outlined),
              label: const Text('돌아가기',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        const Text('메일함에서 인증 확인 링크를 누른 뒤\n인증 완료 버튼을 눌러주세요',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.refresh_outlined),
              onPressed: viewModel.isLoading ? null : viewModel.sendVerifyEmail,
              label: const Text(
                '재전송',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 17,
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: viewModel.isLoading ? null
                  : () => viewModel.verifyFinish(_emailController.text, _passwordController.text),
              label: const Text(
                '인증완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
