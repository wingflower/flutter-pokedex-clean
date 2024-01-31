import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

part 'roulette_ui_event.freezed.dart';

@freezed
sealed class RouletteUiEvent with _$RouletteUiEvent {
  const factory RouletteUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory RouletteUiEvent.showDialog(Pokemon pokemon) = ShowDialog;
}