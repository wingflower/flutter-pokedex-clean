import 'package:pokedex_clean/core/result.dart';

abstract interface class AuthRepository<T> {
  Future<Result<bool>> login(T model);
  Future<Result<void>> logout();
  Future<Result<void>> register(T model);
  Future<Result<void>> requestVerify();
  Future<Result<bool>> isVerified();
}