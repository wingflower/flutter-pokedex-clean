import 'package:pokedex_clean/domain/model/storage.dart';

import '../../core/result.dart';

abstract interface class StorageRepository {
  Future<Result<Storage>> getStorage(String email);

  Future<Result<void>> addStorage(Storage storage);

  Future<Result<void>> updateStorage(Storage storage);

  Future<Result<void>> deleteStorage(Storage storage);
}
