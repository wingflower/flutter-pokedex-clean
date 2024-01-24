import 'package:pokedex_clean/domain/model/pokemon.dart';

abstract interface class PokemonRepository {
  Future<List<Pokemon>> getPokemonList();
}
