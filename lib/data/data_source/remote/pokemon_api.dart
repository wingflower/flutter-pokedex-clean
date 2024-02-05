import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

class PokemonApi {
  Future<Result<List<Pokemon>>> getPokemonList() async {
    try {
      final response = await http.get(Uri.parse(pokemonUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Pokemon> pokemonList =
            jsonData.map((json) => Pokemon.fromJson(json)).toList();

        return Result.success(pokemonList);
      } else {
        return Result.error('서버에서 에러 응답: ${response.statusCode}');
      }
    } catch (e) {
      return const Result.error('데이터를 가져오는 도중 오류가 발생했습니다.');
    }
  }
}
