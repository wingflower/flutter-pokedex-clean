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
        _state = state.copyWith(pokemonListData: pokemonList, isLoading: false);
        notifyListeners();
      },
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }

  Future<void> sortPokemonDataList(String option) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    List<Pokemon> pokemonList = List.from(state.pokemonListData);
    bool boolSortDirection = state.sortDirection;
    bool boolSortIsCollected = state.sortIsCollected;

    print('qwerasdf boolSortDirection $boolSortDirection');
    print('qwerasdf boolSortIsCollected $boolSortIsCollected');

    pokemonList.sort(
      (a, b) {
        if (a.isCollected != b.isCollected) {
          return state.sortIsCollected
              ? (a.isCollected ? -1 : 1)
              : (a.isCollected ? 1 : -1);
        } else {
          return state.sortDirection
              ? a.id.compareTo(b.id)
              : b.id.compareTo(a.id);
        }
      },
    );

    // pokemonList.sort((a, b) {
    //   if (a.isCollected && !b.isCollected) {
    //     return state.sortIsCollected ? -1 : 1;
    //   } else if (!a.isCollected && b.isCollected) {
    //     return state.sortIsCollected ? 1 : -1;
    //   } else {
    //     return state.sortDirection
    //         ? a.id.compareTo(b.id)
    //         : b.id.compareTo(a.id);
    //   }
    // });
    // if (state.sortIsCollected) {
    // } else {
    //   pokemonList.sort((a, b) {
    //     return state.sortDirection
    //         ? a.id.compareTo(b.id)
    //         : b.id.compareTo(a.id);
    //   });
    // }

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

    // if (false) {
    //   pokemonList.sort(
    //     (a, b) {
    //       a.isCollected;
    //       b.isCollected;

    //       if (a.isCollected && !b.isCollected) {
    //         return -1;
    //       } else if (!a.isCollected && b.isCollected) {
    //         return 1;
    //       } else if (state.sortDirection) {
    //         return a.id.compareTo(b.id);
    //       } else {
    //         return b.id.compareTo(a.id);
    //       }
    //     },
    //   );
    // }

    // if(state.sortDirection){
    //   pokemonList.sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));
    // }else{
    //   pokemonList.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    // }

    // if (option == 'reverse') {
    //   pokemonList.sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id)));

    //   print('qwerasdf ${pokemonList[1].id}');
    // } else if (option == 'forward') {
    //   pokemonList.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    // } else if (option == 'collectionChecked') {
    //   pokemonList.sort(
    //     (a, b) {
    //       a.isCollected;
    //       b.isCollected;

    //       if (a.isCollected && !b.isCollected) {
    //         return -1;
    //       } else if (!a.isCollected && b.isCollected) {
    //         return 1;
    //       } else {
    //         return a.id.compareTo(b.id);
    //       }
    //     },
    //   );
    // }
    _state = state.copyWith(
      pokemonListData: pokemonList,
      isLoading: false,
      sortDirection: boolSortDirection,
      sortIsCollected: boolSortIsCollected,
    );
    notifyListeners();
  }
}
