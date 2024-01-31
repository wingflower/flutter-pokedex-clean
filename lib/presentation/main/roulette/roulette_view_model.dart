import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/use_case/collection/draw_pokemon_use_case.dart';

class RouletteViewModel extends ChangeNotifier {
  final DrawPokemonUseCase _drawPokemonUseCase;

  RouletteViewModel({
    required DrawPokemonUseCase drawPokemonUseCase,
  }) : _drawPokemonUseCase = drawPokemonUseCase;

  String drawPokemon(List<Pokemon> pokemonList) {
    final Pokemon pokemon = _drawPokemonUseCase.execute(pokemonList);

    return pokemon.imageurl;
  }
}