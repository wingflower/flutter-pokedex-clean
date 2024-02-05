import 'package:pokedex_clean/domain/model/pokemon.dart';

class SortedByOptionPokemonUseCase {
  List<Pokemon> execute({
    required List<Pokemon> pokemonDataList,
    required List<bool> collectionOption,
    required List<bool> directionOption,
  }) {
    List<Pokemon> sortedPokemonList = _sortedByCollectionPokemonListUseCase(
        pokemonDataList, collectionOption);
    sortedPokemonList = _sortedByDriectionPokemonListUseCase(
        sortedPokemonList, directionOption);

    return sortedPokemonList;
  }

  List<Pokemon> _sortedByCollectionPokemonListUseCase(
      List<Pokemon> pokemonDataList, List<bool> collectionOption) {
    List<Pokemon> resultList = [];
    for (int i = 0; i < collectionOption.length; i++) {
      if (collectionOption[i]) {
        if (i == 1) {
          resultList
              .addAll(pokemonDataList.where((pokemon) => pokemon.isCollected));
        } else if (i == 2) {
          resultList
              .addAll(pokemonDataList.where((pokemon) => !pokemon.isCollected));
        } else {
          resultList.addAll(pokemonDataList);
        }
      }
    }
    return resultList;
  }

  List<Pokemon> _sortedByDriectionPokemonListUseCase(
      List<Pokemon> pokemonDataList, List<bool> directionOption) {
    List<Pokemon> sortedList = List.from(pokemonDataList);

    sortedList.sort((a, b) => directionOption[0]
        ? int.parse(a.id).compareTo(int.parse(b.id))
        : int.parse(b.id).compareTo(int.parse(a.id)));

    return sortedList;
  }
}
