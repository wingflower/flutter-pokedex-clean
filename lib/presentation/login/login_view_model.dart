import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/use_case/user/check_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/login_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/register_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/request_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/reset_password_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/store_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/login/login_ui_event.dart';


class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final StoreUserAccountUseCase _storeUserAccountUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final RequestVerifyUseCase _requestVerifyUseCase;
  final CheckVerifyUseCase _checkVerifyUseCase;

  LoginViewModel({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required StoreUserAccountUseCase storeUserAccountUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required RequestVerifyUseCase requestVerifyUseCase,
    required CheckVerifyUseCase checkVerifyUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _storeUserAccountUseCase = storeUserAccountUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _requestVerifyUseCase = requestVerifyUseCase,
        _checkVerifyUseCase = checkVerifyUseCase;

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
      error: (e) async {
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
          _controller.add(const LoginUiEvent.successLoginButNotVerified());
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

  Future<void> sendVerifyEmail() async {
    _isLoading = true;
    notifyListeners();

    final result = await _requestVerifyUseCase.execute();
    result.when(
      success: (data) => _controller.add(const LoginUiEvent.showSnackBar('이메일 전송됨')),
      error: (e) => _controller.add(LoginUiEvent.showSnackBar(e)),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> verifyFinish(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _checkVerifyUseCase.execute();
    result.when(
      success: (isVerified) async {
        if (isVerified) {
          await _storeUserAccountUseCase.execute(EmailPassword(email: email, password: password));
          _controller.add(const LoginUiEvent.successVerify());
        } else {
          _controller.add(const LoginUiEvent.showSnackBar('인증이 완료되지 않았습니다'));
        }
      },
      error: (e) => LoginUiEvent.showSnackBar(e),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      _controller.add(const LoginUiEvent.showSnackBar('이메일을 입력해주세요'));
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _resetPasswordUseCase.execute(email);
    result.when(
      success: (data) {
        _controller.add(const LoginUiEvent.successResetPassword());
      },
      error: (e) => _controller.add(LoginUiEvent.showSnackBar(e)),
    );

    _isLoading = false;
    notifyListeners();
  }
}