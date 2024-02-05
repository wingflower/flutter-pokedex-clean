import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/data/data_source/remote/pokemon_api.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApi _pokemonApi;

  PokemonRepositoryImpl({
    required PokemonApi pokemonApi,
  }) : _pokemonApi = pokemonApi;

  @override
  Future<Result<List<Pokemon>>> getPokemonList() async {
    final result = _pokemonApi.getPokemonList();
    return result;
  }
}
