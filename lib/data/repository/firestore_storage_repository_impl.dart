import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/storage.dart';
import 'package:pokedex_clean/domain/repository/storage_repository.dart';

class FirestoreStorageRepository implements StorageRepository {
  final FirebaseFirestore _instance;
  final CollectionReference<Map<String, dynamic>> _storageRef;

  FirestoreStorageRepository({
    required FirebaseFirestore firebaseFirestore,
  })  : _instance = firebaseFirestore,
        _storageRef = firebaseFirestore.collection('storage');

  @override
  Future<Result<void>> addStorage(Storage storage) {
    // TODO: implement addStorage
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteStorage(Storage storage) {
    // TODO: implement deleteStorage
    throw UnimplementedError();
  }

  @override
  Future<Result<Storage>> getStorage(String email) async {
    final snapshot = await _storageRef.doc(email).get();
    final json = snapshot.data();

    if (json == null) {
      return const Result.error('Storage 데이터가 없음');
    }

    return Result.success(Storage.fromJson(json));
  }

  @override
  Future<Result<void>> updateStorage(Storage storage) {
    // TODO: implement updateStorage
    throw UnimplementedError();
  }
}
