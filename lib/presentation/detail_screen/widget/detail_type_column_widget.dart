import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';
import 'package:pokedex_clean/presentation/detail_screen/widget/detail_info_title_text_widget.dart';

class DetailTypeColumnWidget extends StatelessWidget {
  const DetailTypeColumnWidget({
    super.key,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
                child: Image.asset(
                  // 'assets/images/types/bug_type.png'
                  'assets/images/types/${TypeEnum.values[int.parse(pokemonData.types[index])].toString().split('.').last}_type.png',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
