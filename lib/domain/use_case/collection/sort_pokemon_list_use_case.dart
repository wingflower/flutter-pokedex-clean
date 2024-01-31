import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class SortedPokemonListUseCase {
  final PokemonRepository _pokemonRepository;

  SortedPokemonListUseCase({
    required PokemonRepository pokemonRepository,
  }) : _pokemonRepository = pokemonRepository;

  // Future<Result<List<Pokemon>>> execute() async {
  //   List<Pokemon> sortedPokemonList = [];

  //   if (boolSortIsCollected) {
  //     List<Pokemon> collectedList = [];
  //     List<Pokemon> notCollectedList = [];
  //     for (var pokemon in pokemonList) {
  //       pokemon.isCollected
  //           ? collectedList.add(pokemon)
  //           : notCollectedList.add(pokemon);
  //     }
  //     collectedList.sort((a, b) => boolSortDirection
  //         ? int.parse(a.id).compareTo(int.parse(b.id))
  //         : int.parse(b.id).compareTo(int.parse(a.id)));
  //     notCollectedList.sort((a, b) => boolSortDirection
  //         ? int.parse(a.id).compareTo(int.parse(b.id))
  //         : int.parse(b.id).compareTo(int.parse(a.id)));

  //     sortedPokemonList = boolSortDirection
  //         ? [...collectedList, ...notCollectedList]
  //         : [...notCollectedList, ...collectedList];
  //   } else {
  //     pokemonList.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
  //     sortedPokemonList =
  //         boolSortDirection ? pokemonList : pokemonList.reversed.toList();
  //   }
  // }
}
