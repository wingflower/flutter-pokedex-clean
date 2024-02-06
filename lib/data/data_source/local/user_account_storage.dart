import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex_clean/core/result.dart';

class UserAccountStorage {
  final FlutterSecureStorage _flutterSecureStorage;

  UserAccountStorage({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  Future<Result<String>> getData(String key) async {
    try {
      String? data = await _flutterSecureStorage.read(key: key);
      return data != null ? Result.success(data) : const Result.error('데이터 없음');
    } catch (e) {
      return const Result.error('데이터를 가져오기 실패');
    }
  }

  Future<Result<void>> saveData(String key, String value) async {
    try {
      await _flutterSecureStorage.write(key: key, value: value);
    } catch (e) {
      return const Result.error('데이터를 저장 실패');
    }
    return const Result.success(null);
  }

  Future<Result<void>> deleteData(String key) async {
    try {
      await _flutterSecureStorage.delete(key: key);
    } catch (e) {
      return const Result.error('데이터 삭제 실패');
    }
    return const Result.success(null);
  }
}
