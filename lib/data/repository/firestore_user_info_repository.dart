import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/domain/repository/user_info_repository.dart';

class FirestoreUserInfoRepository implements UserInfoRepository {
  final FirebaseFirestore _instance;
  late final CollectionReference<Map<String, dynamic>> _userInfoRef =
      _instance.collection('user_info');

  FirestoreUserInfoRepository({
    required FirebaseFirestore instance,
  }) : _instance = instance;

  @override
  Future<Result<UserInfo>> getUserInfo(String email) async {
    final Map<String, dynamic> json;
    try {
      final snapshot = await _userInfoRef.doc(email).get();
      json = snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      return Result.error('이메일 확인. $email');
    }

    if (json.isEmpty) {
      return const Result.success(UserInfo(pokemons: []));
    }
    return Result.success(UserInfo.fromJson(json));
  }

  @override
  Future<Result<void>> updateUserInfo(String email, UserInfo userInfo) async {
    try {
      await _instance
          .collection('user_info')
          .doc(email)
          .set(userInfo.toJson(), SetOptions(merge: true));
      return const Result.success(null);
    } catch (e) {
      return Result.error('네트워크 상태 확인. ($email)');
    }
  }

  @override
  Future<Result<void>> addUserInfo(String email, UserInfo userInfo) {
    // TODO: implement addUserInfo
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteUserInfo(String email) {
    // TODO: implement deleteUserInfo
    throw UnimplementedError();
  }
}
