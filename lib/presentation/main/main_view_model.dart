import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/use_case/collection/get_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/logout_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/remove_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';

class MainViewModel extends ChangeNotifier {
  final LogoutUseCase _logoutUseCase;
  final RemoveUserAccountUseCase _removeUserAccountUseCase;
  final GetPokemonUseCase _getPokemonUseCase;

  MainViewModel({
    required LogoutUseCase logoutUseCase,
    required RemoveUserAccountUseCase removeUserAccountUseCase,
    required GetPokemonUseCase getPokemonUseCase,
  })  : _logoutUseCase = logoutUseCase,
        _getPokemonUseCase = getPokemonUseCase,
        _removeUserAccountUseCase = removeUserAccountUseCase;

  MainState _state = const MainState();
  MainState get state => _state;

  final StreamController<MainUiEvent> _controller = StreamController();

  Stream<MainUiEvent> get stream => _controller.stream;

  Future<void> logout() async {
    final result = await _logoutUseCase.execute();
    result.when(
      success: (data) async {
        await _removeUserAccountUseCase.execute(keyEmail, keyPassword);
        _controller.add(const MainUiEvent.successLogout());
      },
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }

  Future<void> fetchPokemonDataList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final fetchPokemonDataListResult = await _getPokemonUseCase.execute();
    fetchPokemonDataListResult.when(
      success: (pokemonList) {
        _state = state.copyWith(
          pokemonListData: pokemonList,
          isLoading: false,
          sortDirection: true,
          sortIsCollected: false,
        );
        notifyListeners();
      },
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }

  Future<void> sortPokemonDataList(String option) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    List<Pokemon> sortedPokemonList = [];
    List<Pokemon> pokemonList = List.from(state.pokemonListData);
    bool boolSortDirection = state.sortDirection;
    bool boolSortIsCollected = state.sortIsCollected;

    switch (option) {
      case 'direction':
        boolSortDirection = !boolSortDirection;
        break;
      case 'collected':
        boolSortIsCollected = !boolSortIsCollected;
        break;
      default:
        break;
    }

    if (boolSortIsCollected) {
      List<Pokemon> collectedList = [];
      List<Pokemon> notCollectedList = [];
      for (var pokemon in pokemonList) {
        pokemon.isCollected
            ? collectedList.add(pokemon)
            : notCollectedList.add(pokemon);
      }
      collectedList.sort((a, b) => boolSortDirection
          ? int.parse(a.id).compareTo(int.parse(b.id))
          : int.parse(b.id).compareTo(int.parse(a.id)));
      notCollectedList.sort((a, b) => boolSortDirection
          ? int.parse(a.id).compareTo(int.parse(b.id))
          : int.parse(b.id).compareTo(int.parse(a.id)));

      sortedPokemonList = boolSortDirection
          ? [...collectedList, ...notCollectedList]
          : [...notCollectedList, ...collectedList];
    } else {
      pokemonList.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
      sortedPokemonList =
          boolSortDirection ? pokemonList : pokemonList.reversed.toList();
    }

    _state = state.copyWith(
      pokemonListData: sortedPokemonList,
      isLoading: false,
      sortDirection: boolSortDirection,
      sortIsCollected: boolSortIsCollected,
    );
    notifyListeners();
  }
}
