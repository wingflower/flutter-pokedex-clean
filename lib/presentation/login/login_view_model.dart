import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/use_case/user/login_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/register_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/store_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/login/login_ui_event.dart';


class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final StoreUserAccountUseCase _storeUserAccountUseCase;

  LoginViewModel({required LoginUseCase loginUseCase, required RegisterUseCase registerUseCase, required StoreUserAccountUseCase storeUserAccountUseCase})
      : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _storeUserAccountUseCase = storeUserAccountUseCase;

  final StreamController<LoginUiEvent> _controller = StreamController();
  Stream<LoginUiEvent> get stream => _controller.stream;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registerEmailAndPassword(String email, String password) async {
    if(!_isFormValid(email, password)) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _registerUseCase.execute(email, password);

    result.when(
      success: (data) async {
        await _storeUserAccountUseCase.execute(EmailPassword(email: email, password: password));
        _controller.add(const LoginUiEvent.successRegister());
      },
      error: (e) {
        _controller.add(LoginUiEvent.showSnackBar(e));
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInEmailAndPassword(String email, String password) async {
    if(!_isFormValid(email, password)) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _loginUseCase.execute(email, password);
    result.when(
      success: (verified) async {
        if (verified) {
          await _storeUserAccountUseCase.execute(EmailPassword(email: email, password: password));
          _controller.add(const LoginUiEvent.successLogin());
        } else {
          _controller.add(const LoginUiEvent.successRegister());
        }
      },
      error: (e) => _controller.add(LoginUiEvent.showSnackBar(e)),
    );

    _isLoading = false;
    notifyListeners();
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