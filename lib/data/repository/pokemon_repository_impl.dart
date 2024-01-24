import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  @override
  Future<List<Pokemon>> getPokemonList() async {
    const url =
        'https://gist.githubusercontent.com/sc2bat/28d2991fb9e361f0e50fd52ac7c40774/raw/a72d0f8ddfcbff5dc523f626c96f4ef1f1f2e0f4/pokemon_data.json';

    final response = await http.get(Uri.parse(url));

    final List<dynamic> jsonData = jsonDecode(response.body);
    final List<Map<String, dynamic>> pokemonListJson =
        jsonData.cast<Map<String, dynamic>>();

    return pokemonListJson.map((e) => Pokemon.fromMap(e)).toList();
  }
}
