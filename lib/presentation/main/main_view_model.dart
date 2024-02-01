import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/domain/use_case/collection/get_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/collection/search_by_name_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/collection/sort_pokemon_list_use_case.dart';
import 'package:pokedex_clean/domain/use_case/info/add_and_update_user_info_use_case.dart';
import 'package:pokedex_clean/domain/use_case/info/get_user_info_use_case.dart';
import 'package:pokedex_clean/domain/use_case/type/get_type_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/get_user_account_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/logout_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/remove_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';

class MainViewModel extends ChangeNotifier {
  final LogoutUseCase _logoutUseCase;
  final RemoveUserAccountUseCase _removeUserAccountUseCase;
  final GetPokemonUseCase _getPokemonUseCase;
  final GetUserAccountUseCase _getUserAccountUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;
  final AddAndUpdateUserInfoUseCase _addAndUpdateUserInfoUseCase;
  final SearchByNamePokemonUseCase _searchByNamePokemonUseCase;
  final SortedByOptionPokemonUseCase _sortedByOptionPokemonUseCase;
  final GetTypeUseCase _getTypeUseCase;

  MainViewModel({
    required LogoutUseCase logoutUseCase,
    required RemoveUserAccountUseCase removeUserAccountUseCase,
    required GetPokemonUseCase getPokemonUseCase,
    required GetUserAccountUseCase getUserAccountUseCase,
    required GetUserInfoUseCase getUserInfoUseCase,
    required AddAndUpdateUserInfoUseCase addAndUpdateUserInfoUseCase,
    required SearchByNamePokemonUseCase searchByNamePokemonUseCase,
    required SortedByOptionPokemonUseCase sortedByOptionPokemonUseCase,
    required GetTypeUseCase getTypeUseCase,
  })  : _logoutUseCase = logoutUseCase,
        _getPokemonUseCase = getPokemonUseCase,
        _removeUserAccountUseCase = removeUserAccountUseCase,
        _getUserAccountUseCase = getUserAccountUseCase,
        _getUserInfoUseCase = getUserInfoUseCase,
        _addAndUpdateUserInfoUseCase = addAndUpdateUserInfoUseCase,
        _searchByNamePokemonUseCase = searchByNamePokemonUseCase,
        _sortedByOptionPokemonUseCase = sortedByOptionPokemonUseCase,
        _getTypeUseCase = getTypeUseCase {
    _initUserInfo();
  }

  MainState _state = const MainState();
  MainState get state => _state;

  final StreamController<MainUiEvent> _controller = StreamController();

  Stream<MainUiEvent> get stream => _controller.stream;

  Future<void> _initUserInfo() async {
    final result = await _getUserAccountUseCase.execute(keyEmail, keyPassword);

    result.when(
      success: (data) {
        _state = state.copyWith(email: data.$1);
        _getUserInfo();
      }, error: (e) async {
        await _removeUserAccountUseCase.execute(keyEmail, keyPassword);
        _controller.add(const MainUiEvent.errorInitialize('사용자 정보를 초기화하는데 실패했습니다.'));
      },
    );
  }

  Future<void> _getUserInfo() async {
    final result = await _getUserInfoUseCase.execute(state.email);

    result.when(
      success: (userInfo) {
        _state = state.copyWith(userInfo: userInfo);
      },
      error: (e) async {
        await _addAndUpdateUserInfoUseCase.execute(state.email, state.userInfo);
      },
    );
    fetchPokemonDataList();
    fetchTypeList();
  }

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
        for (final numberString in state.userInfo.pokemons) {
          pokemonList.firstWhere((element) => element.id == numberString).isCollected = true;
        }
        _state = state.copyWith(
          pokemonListData: pokemonList,
          isLoading: false,
        );
        notifyListeners();
        sortedByOptionPokemonList();
      },
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }

  void sortedByOptionPokemonList() {
    List<Pokemon> sortedPokemonList = [];

    sortedPokemonList = _sortedByOptionPokemonUseCase.execute(
      pokemonDataList: state.pokemonListData,
      collectionOption: state.sortIsCollected,
      directionOption: state.sortDirection,
    );

    _state = state.copyWith(filterListData: sortedPokemonList);
    notifyListeners();
  }

  void searchPokemon(String name) {
    sortedByOptionPokemonList();
    if (name.isEmpty) {
      _state = state.copyWith(isFiltered: false);
      notifyListeners();
      return;
    }

    List<Pokemon> filterList =
        _searchByNamePokemonUseCase.execute(name, state.filterListData);
    _state = state.copyWith(filterListData: filterList, isFiltered: true);
    notifyListeners();
  }

  // 사용자 옵션 그리드 열 수 옵션 변경
  void updateGridColumnOption(double gridViewColumnCount) {
    _state = state.copyWith(gridCrossAxisCount: gridViewColumnCount.toInt());
    notifyListeners();
    sortedByOptionPokemonList();
  }

  // 사용자 옵션 수집여부 옵션 변경
  void updateCollectionOption(List<bool> collectionOption, int index) {
    for (int i = 0; i < collectionOption.length; i++) {
      collectionOption[i] = i == index;
    }
    _state = state.copyWith(sortIsCollected: collectionOption);
    notifyListeners();
    sortedByOptionPokemonList();
  }

  // 사용자 옵션 방향 옵션 변경
  void updateDirectionOption(List<bool> directionOption, int index) {
    for (int i = 0; i < directionOption.length; i++) {
      directionOption[i] = i == index;
    }
    _state = state.copyWith(sortDirection: directionOption);
    notifyListeners();
    sortedByOptionPokemonList();
  }

  Future<void> fetchTypeList() async {
    final fetchPokemonDataListResult = await _getTypeUseCase.execute();
    fetchPokemonDataListResult.when(
      success: (typeList) {
        _state = state.copyWith(
          typeList: typeList,
        );
        notifyListeners();
      },
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }

  TypeModel getTypeByTypeId(String typeId) {
    return state.typeList.firstWhere((element) => element.id == typeId);
  }

  void refresh() {
    final List<Pokemon> pokemonList = state.pokemonListData;

    for (final numberString in state.userInfo.pokemons) {
      pokemonList.firstWhere((element) => element.id == numberString).isCollected = true;
    }
    _state = state.copyWith(
      pokemonListData: pokemonList,
    );
    notifyListeners();
  }
}
