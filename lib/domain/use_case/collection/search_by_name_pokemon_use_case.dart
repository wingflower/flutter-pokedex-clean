import 'package:pokedex_clean/domain/model/pokemon.dart';

class SearchByNamePokemonUseCase {
  List<Pokemon> execute(String name, List<Pokemon> list) {
    return list
        .where((pokemon) =>
            pokemon.isCollected && pokemon.description.name.contains(name))
        .toList();
  }
}
