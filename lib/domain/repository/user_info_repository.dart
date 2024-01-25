import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';

abstract interface class UserInfoRepository {
  Future<Result<UserInfo>> getUserInfo(String email);

  Future<Result<void>> addUserInfo(String email, UserInfo userInfo);

  Future<Result<void>> updateUserInfo(String email, UserInfo userInfo);

  Future<Result<void>> deleteUserInfo(String email);
}