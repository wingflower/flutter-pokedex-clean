import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

abstract interface class PokemonRepository {
  Future<Result<List<Pokemon>>> getPokemonList();
}
