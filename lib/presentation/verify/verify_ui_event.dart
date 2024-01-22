import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_ui_event.freezed.dart';

@freezed
sealed class VerifyUiEvent with _$VerifyUiEvent {
  const factory VerifyUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory VerifyUiEvent.successVerify() = SuccessVerify;
}