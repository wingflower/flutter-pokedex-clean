import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/domain/use_case/collection/draw_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/info/add_and_update_user_info_use_case.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_ui_event.dart';

class RouletteViewModel extends ChangeNotifier {
  final DrawPokemonUseCase _drawPokemonUseCase;
  final AddAndUpdateUserInfoUseCase _addAndUpdateUserInfoUseCase;

  RouletteViewModel({
    required DrawPokemonUseCase drawPokemonUseCase,
    required AddAndUpdateUserInfoUseCase addAndUpdateUserInfoUseCase,
  })  : _drawPokemonUseCase = drawPokemonUseCase,
        _addAndUpdateUserInfoUseCase = addAndUpdateUserInfoUseCase;

  final StreamController<RouletteUiEvent> _controller = StreamController();

  Stream<RouletteUiEvent> get stream => _controller.stream;

  Future<void> drawPokemon(List<Pokemon> pokemonList, UserInfo userInfo, String email) async {
    final Pokemon pokemon = _drawPokemonUseCase.execute(pokemonList);

    userInfo.pokemons.add(pokemon.id);

    final Result<void> result = await _addAndUpdateUserInfoUseCase.execute(email, userInfo);

    result.when(
      success: (data) {
        _controller.add(
          RouletteUiEvent.showDialog(pokemon),
        );
      },
      error: (e) => _controller.add(
        RouletteUiEvent.showSnackBar(e),
      ),
    );
  }
}
