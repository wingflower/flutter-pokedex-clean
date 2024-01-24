import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class GetPokemonUseCase {
  final PokemonRepository _pokemonRepository;

  GetPokemonUseCase({required PokemonRepository pokemonRepository})
      : _pokemonRepository = pokemonRepository;

  Future<List<Pokemon>> execute() async {
    final pokemonList = await _pokemonRepository.getPokemonList();
    return pokemonList;
  }
}
