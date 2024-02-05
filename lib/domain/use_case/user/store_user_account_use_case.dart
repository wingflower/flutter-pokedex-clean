import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';

class StoreUserAccountUseCase {
  final UserAccountRepository<String, String> _userAccountRepository;

  StoreUserAccountUseCase(
      {required UserAccountRepository<String, String> userAccountRepository})
      : _userAccountRepository = userAccountRepository;
  Future<void> execute(EmailPassword emailPassword) async {
    await _userAccountRepository.saveData(keyEmail, emailPassword.email);
    await _userAccountRepository.saveData(keyPassword, emailPassword.password);
  }
}
