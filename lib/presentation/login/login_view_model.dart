import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/use_case/login_use_case.dart';
import 'package:pokedex_clean/domain/use_case/register_use_case.dart';
import 'package:pokedex_clean/presentation/login/login_ui_event.dart';


class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  LoginViewModel({required LoginUseCase loginUseCase, required RegisterUseCase registerUseCase})
      : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase;

  final StreamController<LoginUiEvent> _controller = StreamController();

  Stream<LoginUiEvent> get stream => _controller.stream;

  Future<void> registerEmailAndPassword(String email, String password) async {
    if(!_isFormValid(email, password)) {
      return;
    }

    final result = await _registerUseCase.execute(email, password);

    result.when(
      success: (data) {
        _controller.add(const LoginUiEvent.successRegister());
      },
      error: (e) {
        _controller.add(LoginUiEvent.showSnackBar(e));
      },
    );
  }

  Future<void> signInEmailAndPassword(String email, String password) async {
    if(!_isFormValid(email, password)) {
      return;
    }

    final result = await _loginUseCase.execute(email, password);
    result.when(
      success: (verified) {
        if (verified) {
          _controller.add(const LoginUiEvent.successLogin());
        } else {
          _controller.add(const LoginUiEvent.successRegister());
        }
      },
      error: (e) => _controller.add(LoginUiEvent.showSnackBar(e)),
    );
  }

  bool _isFormValid(String email, String password) {
    if (email.isEmpty) {
      _controller.add(const LoginUiEvent.showSnackBar('이메일을 입력해주세요'));
      return false;
    }
    if(password.isEmpty) {
      _controller.add(const LoginUiEvent.showSnackBar('패스워드를 입력해주세요'));
      return false;
    }

    return true;
  }
}