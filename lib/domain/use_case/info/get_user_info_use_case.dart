import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/domain/repository/user_info_repository.dart';

class GetUserInfoUseCase {
  final UserInfoRepository _userInfoRepository;

  const GetUserInfoUseCase({
    required UserInfoRepository userInfoRepository,
  }) : _userInfoRepository = userInfoRepository;

  Future<Result<UserInfo>> execute(String email) {
    return _userInfoRepository.getUserInfo(email);
  }
}