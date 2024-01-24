import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Result<void>> execute() {
    return _authRepository.logout();
  }
}