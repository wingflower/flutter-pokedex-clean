import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default(false) bool isLoading,
    @Default(0) int rewardTime,
    @Default([]) List<Pokemon> pokemonListData,
    @Default(2) int gridCrossAxisCount,
    @Default(true) bool sortDirection,
    @Default(false) bool sortIsCollected,
  }) = _MainState;
}
