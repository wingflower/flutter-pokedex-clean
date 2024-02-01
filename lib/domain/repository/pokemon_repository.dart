import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

abstract interface class PokemonRepository {
  Future<Result<List<Pokemon>>> getPokemonList();
  List<Pokemon> sortedByCollectionPokemonListUseCase(
      List<Pokemon> pokemonDataList, List<bool> collectionOption);
  List<Pokemon> sortedByDriectionPokemonListUseCase(
      List<Pokemon> pokemonDataList, List<bool> directionOption);
}
