import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/use_case/user/remove_user_account_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/reset_password_use_case.dart';
import 'package:pokedex_clean/presentation/login/reset_password/reset_password_ui_event.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordViewModel({required ResetPasswordUseCase resetPasswordUseCase})
      : _resetPasswordUseCase = resetPasswordUseCase;

  final StreamController<ResetPasswordUiEvent> _controller = StreamController();
  Stream<ResetPasswordUiEvent> get stream => _controller.stream;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      _controller.add(const ResetPasswordUiEvent.showSnackBar('이메일을 입력해주세요'));
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _resetPasswordUseCase.execute(email);
    result.when(
      success: (data) {
        _controller.add(const ResetPasswordUiEvent.successResetPassword());
      },
      error: (e) => _controller.add(ResetPasswordUiEvent.showSnackBar(e)),
    );

    _isLoading = false;
    notifyListeners();
  }
}