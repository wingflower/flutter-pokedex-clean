import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/use_case/get_user_account_use_case.dart';
import 'package:pokedex_clean/domain/use_case/login_use_case.dart';
import 'package:pokedex_clean/domain/use_case/remove_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/splash/login_status.dart';

class SplashViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final GetUserAccountUseCase _getUserAccountUseCase;
  final RemoveUserAccountUseCase _removeUserAccountUseCase;

  SplashViewModel(
      {required LoginUseCase loginUseCase,
      required GetUserAccountUseCase getUserAccountUseCase,
      required RemoveUserAccountUseCase removeUserAccountUseCase})
      : _loginUseCase = loginUseCase,
        _getUserAccountUseCase = getUserAccountUseCase,
        _removeUserAccountUseCase = removeUserAccountUseCase {
    _getUserInfo();
  }

  final StreamController<LoginStatus> _loginStatus = StreamController();
  Stream<LoginStatus> get loginStatus => _loginStatus.stream;

  Future<void> _getUserInfo() async {
    _loginStatus.add(LoginStatus.processing);

    final result = await _getUserAccountUseCase.execute(keyEmail, keyPassword);
    result.when(
      success: (data) async {
        await _login(data.$1, data.$2);
      },
      error: (e) async {
        await _removeUserAccountUseCase.execute(keyEmail, keyPassword);
        _loginStatus.add(LoginStatus.loggedOut);
      },
    );
  }

  Future<void> _login(String email, String password) async {
    final result = await _loginUseCase.execute(email, password);
    result.when(
      success: (isVerified) {
        if (isVerified) {
          // TODO go main
        } else {
          // TODO go login
        }
      },
      error: (e) {
        // TODO go login
      },
    );
  }
}
