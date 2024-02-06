import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/model/type.dart';

class TypeApi {
  Future<Result<List<TypeModel>>> getTypeList() async {
    try {
      final response = await http.get(Uri.parse(typeUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<TypeModel> typeModelList =
            jsonData.map((json) => TypeModel.fromJson(json)).toList();

        return Result.success(typeModelList);
      } else {
        return Result.error('서버에서 에러 응답: ${response.statusCode}');
      }
    } catch (e) {
      return const Result.error('데이터를 가져오는 도중 오류가 발생했습니다.');
    }
  }
}
