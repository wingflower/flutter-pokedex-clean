import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class SortedByOptionPokemonUseCase {
  final PokemonRepository _pokemonRepository;

  SortedByOptionPokemonUseCase({
    required PokemonRepository pokemonRepository,
  }) : _pokemonRepository = pokemonRepository;

  List<Pokemon> execute({
    required List<Pokemon> pokemonDataList,
    required List<bool> collectionOption,
    required List<bool> directionOption,
  }) {
    List<Pokemon> sortedPokemonList =
        _pokemonRepository.sortedByCollectionPokemonListUseCase(
            pokemonDataList, collectionOption);
    sortedPokemonList = _pokemonRepository.sortedByDriectionPokemonListUseCase(
        sortedPokemonList, directionOption);

    return sortedPokemonList;
  }
}
