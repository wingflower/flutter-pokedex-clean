
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository<EmailPassword> _authRepository;

  LoginUseCase({required AuthRepository<EmailPassword> authRepository}) : _authRepository = authRepository;

  Future<Result<bool>> execute(String email, String password) {
    return _authRepository.login(EmailPassword(email: email, password: password));
  }
}