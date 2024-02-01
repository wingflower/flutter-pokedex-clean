import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/type.dart';

abstract interface class TypeRepository {
  Future<Result<List<TypeModel>>> getTypeList();
}
