import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/domain/repository/user_info_repository.dart';

class AddAndUpdateUserInfoUseCase {
  final UserInfoRepository _userInfoRepository;

  const AddAndUpdateUserInfoUseCase({
    required UserInfoRepository userInfoRepository,
  }) : _userInfoRepository = userInfoRepository;

  Future<Result<void>> execute(String email, UserInfo userInfo) {
    return _userInfoRepository.updateUserInfo(email, userInfo);
  }
}
