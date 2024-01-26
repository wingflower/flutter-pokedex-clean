import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/use_case/user/check_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/request_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/store_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/login/verify/verify_ui_event.dart';

class VerifyViewModel extends ChangeNotifier {
  final RequestVerifyUseCase _verifyUseCase;
  final CheckVerifyUseCase _checkVerifyUseCase;
  final StoreUserAccountUseCase _storeUserAccountUseCase;

  VerifyViewModel(
      {required RequestVerifyUseCase verifyUseCase,
      required CheckVerifyUseCase checkVerifyUseCase,
      required StoreUserAccountUseCase storeUserAccountUseCase})
      : _verifyUseCase = verifyUseCase,
        _checkVerifyUseCase = checkVerifyUseCase,
        _storeUserAccountUseCase = storeUserAccountUseCase {
    sendVerifyEmail();
  }

  final StreamController<VerifyUiEvent> _controller = StreamController();

  Stream<VerifyUiEvent> get stream => _controller.stream;

  Future<void> sendVerifyEmail() async {
    final result = await _verifyUseCase.execute();
    result.when(
      success: (data) => _controller.add(const VerifyUiEvent.showSnackBar('이메일 전송됨')),
      error: (e) => _controller.add(VerifyUiEvent.showSnackBar(e)),
    );
  }

  Future<void> verifyFinish(EmailPassword emailPassword) async {
    final result = await _checkVerifyUseCase.execute();
    result.when(
      success: (isVerified) async {
        if (isVerified) {
          await _storeUserAccountUseCase.execute(emailPassword);
          _controller.add(const VerifyUiEvent.successVerify());
        } else {
          _controller.add(const VerifyUiEvent.showSnackBar('인증이 완료되지 않았습니다'));
        }
      },
      error: (e) => VerifyUiEvent.showSnackBar(e),
    );
  }
}
