import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default('') String email,
    @Default(UserInfo(pokemons: [])) UserInfo userInfo,
    @Default(false) bool isLoading,
    @Default(false) bool isFiltered,
    @Default([]) List<Pokemon> pokemonListData,
    @Default([]) List<Pokemon> filterListData,
    @Default(2) int gridCrossAxisCount,
    @Default([true, false, false]) List<bool> sortIsCollected,
    @Default([true, false]) List<bool> sortDirection,
  }) = _MainState;
}
