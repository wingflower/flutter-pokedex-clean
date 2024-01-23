import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Result<void>> execute(String email) {
    return _authRepository.resetPassword(email);
  }
}