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
  Future<void> addUserInfo(String email, UserInfo userInfo) async {
    await _instance.collection('user_info').doc(email).set(userInfo.toJson());
  }

  @override
  Future<void> deleteUserInfo(String email) async {
    final snapshot = await _userInfoRef.doc(email).get();
    final json = snapshot.data();

    if (json != null) {
      await _instance
          .collection('user_info')
          .doc(email)
          .set(const UserInfo(pokemons: []).toJson());
    }
  }

  @override
  Future<Result<UserInfo>> getUserInfo(String email) async {
    final snapshot = await _userInfoRef.doc(email).get();
    final json = snapshot.data();

    if (json == null) {
      return const Result.success(UserInfo(pokemons: []));
    }
    return Result.success(UserInfo.fromJson(json));
  }

  @override
  Future<void> updateUserInfo(String email, UserInfo userInfo) async {
    await _instance
        .collection('user_info')
        .doc(email)
        .set(userInfo.toJson(), SetOptions(merge: true));
  }
}
