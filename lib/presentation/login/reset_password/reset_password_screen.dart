import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/presentation/common.dart';
import 'package:pokedex_clean/presentation/login/reset_password/reset_password_ui_event.dart';
import 'package:pokedex_clean/presentation/login/reset_password/reset_password_view_model.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;
  const ResetPasswordScreen({super.key, this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final ResetPasswordViewModel viewModel = context.read();
      _subscription = viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            showSnackBar(context, event.message);
          case SuccessResetPassword():
            showSimpleDialog(
              context,
              cancelable: false,
              title: '패스워드 초기화',
              content: '${_emailController.text}에\n비밀번호 재설정 메일이 전송되었습니다.',
              confirmAction: context.pop,
            );
        }
      });
    });
    _emailController.text = widget.email ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ResetPasswordViewModel viewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 재설정'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'email'),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: viewModel.isLoading ? null
              : () => context.read<ResetPasswordViewModel>().resetPassword(_emailController.text),
            child: const Text('비밀번호 재설정'),
          ),
        ],
      ),
    );
  }
}
