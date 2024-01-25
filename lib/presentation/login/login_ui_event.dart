import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_ui_event.freezed.dart';

@freezed
sealed class LoginUiEvent with _$LoginUiEvent {
  const factory LoginUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory LoginUiEvent.successRegister() = SuccessRegister;
  const factory LoginUiEvent.successLogin() = SuccessLogin;
  const factory LoginUiEvent.successVerify() = SuccessVerify;
  const factory LoginUiEvent.successResetPassword() = SuccessResetPassword;
}