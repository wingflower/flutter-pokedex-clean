import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Result<void>> execute(String email, String password) {
    return _authRepository.register(EmailPassword(email: email, password: password));
  }
}