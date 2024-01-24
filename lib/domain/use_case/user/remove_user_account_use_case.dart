import 'dart:async';

import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';


class RemoveUserAccountUseCase {
  final UserAccountRepository<String, String> _userAccountRepository;

  RemoveUserAccountUseCase({required UserAccountRepository<String, String> userAccountRepository}) : _userAccountRepository = userAccountRepository;

  Future<Result<void>> execute(String emailKey, String passwordKey) async {
    final emailResult = await _userAccountRepository.deleteData(emailKey);
    final passwordResult = await _userAccountRepository.deleteData(passwordKey);

    return emailResult.when(
        success: (email) =>
            passwordResult.when(
                success: (password) => const Result.success(null),
                error: (e) => Result.error(e)),
        error: (e) => Result.error(e)
    );
  }
}
