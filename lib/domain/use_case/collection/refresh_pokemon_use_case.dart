import 'package:pokedex_clean/domain/model/pokemon.dart';

class RefreshPokemonUseCase {
  List<Pokemon> execute(List<Pokemon> pokemonList, List<String> myCollectionIDList) {
    for (final id in myCollectionIDList) {
      final pokemon = pokemonList.firstWhere((element) => element.id == id);
      if (!pokemon.isCollected) {
        pokemon.isNew = true;
        pokemon.isCollected = true;
      }
    }
    return pokemonList;
  }
}