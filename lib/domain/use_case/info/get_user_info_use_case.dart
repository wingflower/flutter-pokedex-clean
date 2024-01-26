import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/domain/repository/user_info_repository.dart';

class GetUserInfoUseCase {
  final UserInfoRepository _repository;

  const GetUserInfoUseCase({
    required UserInfoRepository repository,
  }) : _repository = repository;

  Future<Result<UserInfo>> execute(String email) {
    return _repository.getUserInfo(email);
  }
}