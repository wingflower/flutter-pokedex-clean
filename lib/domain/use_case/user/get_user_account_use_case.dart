import 'dart:async';

import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';


class GetUserAccountUseCase {
  final UserAccountRepository<String, String> _userAccountRepository;

  GetUserAccountUseCase({required UserAccountRepository<String, String> userAccountRepository}) : _userAccountRepository = userAccountRepository;

  Future<Result<(String, String)>> execute(String emailKey, String passwordKey) async {
    final emailResult = await _userAccountRepository.getData(emailKey);
    final passwordResult = await _userAccountRepository.getData(passwordKey);

    return emailResult.when(
        success: (email) =>
          passwordResult.when(
            success: (password) => Result.success((email, password)),
            error: (e) => Result.error(e)),
        error: (e) => Result.error(e)
    );
  }
}
