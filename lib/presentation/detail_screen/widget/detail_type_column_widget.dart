import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';
import 'package:pokedex_clean/presentation/detail_screen/widget/detail_info_title_text_widget.dart';

import '../../common/widget/type_page_view_container.dart';

class DetailTypeColumnWidget extends StatelessWidget {
  const DetailTypeColumnWidget({
    super.key,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> testType = {
      "id": "4",
      "name": "독",
      "imageurl": "assets/images/types/poison_type.png",
      "double_damage_to": [
        {"id": "12"},
        {"id": "18"},
        {"id": "4"},
        {"id": "5"},
        {"id": "6"},
        {"id": "8"}
      ],
      "double_damage_from": [
        {"id": "5"},
        {"id": "14"}
      ],
      "half_damage_to": [
        {"id": "4"},
        {"id": "5"},
        {"id": "6"},
        {"id": "8"}
      ],
      "half_damage_from": [
        {"id": "2"},
        {"id": "4"},
        {"id": "7"},
        {"id": "12"},
        {"id": "18"}
      ],
      "no_damage_to": [
        {"id": "9"}
      ],
      "no_damage_from": []
    };
    List<Map<String, dynamic>> doubleDamageTo =
        _nullCheckAndCastToMap(testType["double_damage_to"]);
    List<Map<String, dynamic>> doubleDamageFrom =
        _nullCheckAndCastToMap(testType["double_damage_from"]);
    List<Map<String, dynamic>> halfDamageTo =
        _nullCheckAndCastToMap(testType["half_damage_to"]);
    List<Map<String, dynamic>> halfDamageFrom =
        _nullCheckAndCastToMap(testType["half_damage_from"]);
    List<Map<String, dynamic>> noDamageTo =
        _nullCheckAndCastToMap(testType["no_damage_to"]);
    List<Map<String, dynamic>> noDamageFrom =
        _nullCheckAndCastToMap(testType["no_damage_from"]);

    List<String> goodForType =
        _removeDuplicates(doubleDamageTo, halfDamageFrom);
    List<String> badForType = _removeDuplicates(doubleDamageFrom, halfDamageTo);
    List<String> noneForType = _removeDuplicates(noDamageTo, noDamageFrom);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Type
            const DetailInfoTitleTextWidget(title: '타입'),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ],
        ),
        Row(
          children: List.generate(
            pokemonData.types.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      getTypeImagebyTypeId(
                                          pokemonData.types[index]),
                                      width: 64.0,
                                      height: 64.0,
                                    ),
                                    Text(
                                      '타입 ${testType["name"]} 의 정보',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close_outlined,
                                    size: 32.0,
                                  ),
                                ),
                              ],
                            ),
                            scrollable: true,
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: PageView(
                                children: [
                                  TypePageViewContainer(
                                      title: 'good',
                                      goodForType: goodForType,
                                      color: Colors.blue),
                                  TypePageViewContainer(
                                      title: 'bad',
                                      goodForType: badForType,
                                      color: Colors.red),
                                  TypePageViewContainer(
                                      title: 'none',
                                      goodForType: noneForType,
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Image.asset(
                  getTypeImagebyTypeId(pokemonData.types[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> _nullCheckAndCastToMap(dynamic inputDynamic) {
  if (inputDynamic is List<Map<String, dynamic>>) {
    return inputDynamic;
  }
  return [];
}

List<String> _removeDuplicates(
    List<Map<String, dynamic>> list1, List<Map<String, dynamic>> list2) {
  Set<String> resultList = {};

  for (var entry in list1) {
    resultList.add(entry['id']);
  }

  for (var entry in list2) {
    resultList.add(entry['id']);
  }

  return resultList.toList();
}
