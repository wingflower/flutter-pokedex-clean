import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';

abstract interface class UserInfoRepository {
  Future<Result<UserInfo>> getUserInfo(String email);

  Future<void> addUserInfo(String email, UserInfo userInfo);

  Future<void> updateUserInfo(String email, UserInfo userInfo);

  Future<void> deleteUserInfo(String email);
}