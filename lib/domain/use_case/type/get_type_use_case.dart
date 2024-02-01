import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/domain/repository/type_repository.dart';

class GetTypeUseCase {
  final TypeRepository _typeRepository;

  GetTypeUseCase({required TypeRepository pokemonRepository})
      : _typeRepository = pokemonRepository;

  Future<Result<List<TypeModel>>> execute() async {
    final pokemonListResult = await _typeRepository.getTypeList();

    return pokemonListResult.when(
        success: (pokemonList) {
          return Result.success(pokemonList);
        },
        error: (e) => Result.error(e));
  }
}
