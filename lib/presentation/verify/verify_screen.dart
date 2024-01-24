import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/presentation/common.dart';
import 'package:pokedex_clean/presentation/verify/verify_ui_event.dart';
import 'package:pokedex_clean/presentation/verify/verify_view_model.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  final EmailPassword emailPassword;
  const VerifyScreen({super.key, required this.emailPassword});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    Future.microtask(() {
      final VerifyViewModel viewModel = context.read();
      _subscription = viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            showSnackBar(context, event.message);
          case SuccessVerify():
            context.go('/main');
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
    final VerifyViewModel viewModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이메일 인증'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('메일함에서 인증 확인 링크를 누른 뒤\n인증 완료 버튼을 눌러주세요',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                viewModel.sendVerifyEmail();
              }, child: const Text('재전송')),
              ElevatedButton(onPressed: (){
                viewModel.verifyFinish(widget.emailPassword);
              }, child: const Text('인증완료'))
            ],
          )
        ],
      ),
    );
  }
}
