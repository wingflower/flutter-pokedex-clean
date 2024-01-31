import 'dart:math';

import 'package:pokedex_clean/domain/model/pokemon.dart';

class DrawPokemonUseCase {
  Pokemon execute(List<Pokemon> pokemonList) {
    final random = Random().nextInt(pokemonList.length);

    return pokemonList[random];
  }
}