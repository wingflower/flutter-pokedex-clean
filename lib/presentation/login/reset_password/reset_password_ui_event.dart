import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_ui_event.freezed.dart';

@freezed
sealed class ResetPasswordUiEvent with _$ResetPasswordUiEvent {
  const factory ResetPasswordUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory ResetPasswordUiEvent.successResetPassword() = SuccessResetPassword;
}