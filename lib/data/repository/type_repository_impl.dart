import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/data/data_source/remote/type_api.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/domain/repository/type_repository.dart';

class TypeRepositoryImpl implements TypeRepository {
  final TypeApi _typeApi;

  TypeRepositoryImpl({required TypeApi typeApi}) : _typeApi = typeApi;

  @override
  Future<Result<List<TypeModel>>> getTypeList() async {
    return _typeApi.getTypeList();
  }
}
