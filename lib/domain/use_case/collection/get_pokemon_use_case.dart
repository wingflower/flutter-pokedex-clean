import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class GetPokemonUseCase {
  final PokemonRepository _pokemonRepository;

  GetPokemonUseCase({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository;

  Future<Result<List<Pokemon>>> execute() async {
    final pokemonListResult = await _pokemonRepository.getPokemonList();

    return pokemonListResult.when(
        success: (pokemonList) {
          return Result.success(pokemonList);
        },
        error: (e) => Result.error(e));
  }
}
