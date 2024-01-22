import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';

class UserAccountRepositoryImpl implements UserAccountRepository<String, String> {
  final FlutterSecureStorage _flutterSecureStorage;

  UserAccountRepositoryImpl({required FlutterSecureStorage flutterSecureStorage}) : _flutterSecureStorage = flutterSecureStorage;


  @override
  Future<Result<String>> getData(String key) async {
    try {
      String? data = await _flutterSecureStorage.read(key: key);
      return data != null
          ? Result.success(data)
          : const Result.error('데이터 없음');
    } catch (e) {
      return const Result.error('데이터를 가져오기 실패');
    }
  }

  @override
  Future<Result<void>> saveData(String key, String value) async {
    try {
      await _flutterSecureStorage.write(key: key, value: value);
    } catch (e) {
      return const Result.error('데이터를 저장 실패');
    }
    return const Result.success(null);
  }

  @override
  Future<Result<void>> deleteData(String key) async {
    try {
      await _flutterSecureStorage.delete(key: key);
    } catch (e) {
      return const Result.error('데이터 삭제 실패');
    }
    return const Result.success(null);
  }

}