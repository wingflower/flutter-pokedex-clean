import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  @override
  Future<Result<List<Pokemon>>> getPokemonList() async {
    try {
      const url =
          'https://gist.githubusercontent.com/sc2bat/28d2991fb9e361f0e50fd52ac7c40774/raw/48a3eb10ff8094a300775471c1d8b7e0bbb29f09/pokemon_data.json';

      final response = await http.get(Uri.parse(url));

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

  @override
  List<Pokemon> sortedByCollectionPokemonListUseCase(
      List<Pokemon> pokemonDataList, List<bool> collectionOption) {
    List<Pokemon> resultList = [];
    for (int i = 0; i < collectionOption.length; i++) {
      if (collectionOption[i]) {
        if (i == 1) {
          resultList
              .addAll(pokemonDataList.where((pokemon) => pokemon.isCollected));
        } else if (i == 2) {
          resultList
              .addAll(pokemonDataList.where((pokemon) => !pokemon.isCollected));
        } else {
          resultList.addAll(pokemonDataList);
        }
      }
    }
    return resultList;
  }

  @override
  List<Pokemon> sortedByDriectionPokemonListUseCase(
      List<Pokemon> pokemonDataList, List<bool> directionOption) {
    List<Pokemon> sortedList = List.from(pokemonDataList);

    sortedList.sort((a, b) => directionOption[0]
        ? int.parse(a.id).compareTo(int.parse(b.id))
        : int.parse(b.id).compareTo(int.parse(a.id)));

    return sortedList;
  }
}
