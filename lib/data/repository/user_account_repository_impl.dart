import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/data/data_source/local/user_account_storage.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';

class UserAccountRepositoryImpl
    implements UserAccountRepository<String, String> {
  final UserAccountStorage _userAccountStorage;

  UserAccountRepositoryImpl({
    required UserAccountStorage userAccountStorage,
  }) : _userAccountStorage = userAccountStorage;

  @override
  Future<Result<String>> getData(String key) async {
    return _userAccountStorage.getData(key);
  }

  @override
  Future<Result<void>> saveData(String key, String value) async {
    return _userAccountStorage.saveData(key, value);
  }

  @override
  Future<Result<void>> deleteData(String key) async {
    return _userAccountStorage.deleteData(key);
  }
}
