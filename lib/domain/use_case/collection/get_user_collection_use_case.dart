import '../../../core/result.dart';
import '../../model/storage.dart';
import '../../repository/storage_repository.dart';

class GetUserCollectionUseCase {
  final StorageRepository _repository;

  const GetUserCollectionUseCase({
    required StorageRepository repository,
  }) : _repository = repository;

  Future<Result<Storage>> execute(String email) async {
    return _repository.getStorage(email);
  }

}