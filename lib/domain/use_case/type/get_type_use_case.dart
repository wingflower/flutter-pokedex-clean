import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/domain/repository/type_repository.dart';

class GetTypeUseCase {
  final TypeRepository _typeRepository;

  GetTypeUseCase({required TypeRepository pokemonRepository})
      : _typeRepository = pokemonRepository;

  Future<Result<List<TypeModel>>> execute(String? typeId) async {
    final pokemonListResult = await _typeRepository.getTypeList();

    return pokemonListResult.when(
        success: (pokemonList) {
          if (typeId != null) {
            pokemonList.where((typeModel) => typeModel.id.contains(typeId));
          }
          return Result.success(pokemonList);
        },
        error: (e) => Result.error(e));
  }
}
