import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/use_case/check_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/request_verify_use_case.dart';
import 'package:pokedex_clean/presentation/verify/verify_ui_event.dart';

class VerifyViewModel extends ChangeNotifier {
  final RequestVerifyUseCase _verifyUseCase;
  final CheckVerifyUseCase _checkVerifyUseCase;

  VerifyViewModel({required RequestVerifyUseCase verifyUseCase, required CheckVerifyUseCase checkVerifyUseCase})
      : _verifyUseCase = verifyUseCase,
        _checkVerifyUseCase = checkVerifyUseCase {
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

  Future<void> verifyFinish() async {
    final result = await _checkVerifyUseCase.execute();
    result.when(
      success: (isVerify) {
        _controller.add(isVerify
            ? const VerifyUiEvent.successVerify()
            : const VerifyUiEvent.showSnackBar('인증이 완료되지 않았습니다')
        );
      },
      error: (e) => VerifyUiEvent.showSnackBar(e),
    );
  }
}
