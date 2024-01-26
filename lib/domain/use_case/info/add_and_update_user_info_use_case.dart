import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/domain/repository/user_info_repository.dart';

class AddAndUpdateUserInfoUseCase {
  final UserInfoRepository _repository;

  const AddAndUpdateUserInfoUseCase({
    required UserInfoRepository repository,
  }) : _repository = repository;

  Future<Result<void>> execute(String email, UserInfo userInfo) {
    return _repository.updateUserInfo(email, userInfo);
  }
}