import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';

class CheckVerifyUseCase {
  final AuthRepository _authRepository;

  CheckVerifyUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Result<bool>> execute() {
    return _authRepository.isVerified();
  }
}