import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_id_text_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_image_widget.dart';

class FourthColumnGridViewWidget extends StatelessWidget {
  const FourthColumnGridViewWidget({
    super.key,
    required this.pokemon,
    required this.gridCrossAxisCount,
  });

  final Pokemon pokemon;
  final int gridCrossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PokemonImageWidget(
          isCollected: pokemon.isCollected,
          imageurl: pokemon.imageurl,
          gridCrossAxisCount: gridCrossAxisCount,
        ),
        Positioned(
          top: 4.0,
          right: 4.0,
          child: PokemonIdTextWidget(
            id: pokemon.id,
            gridCrossAxisCount: gridCrossAxisCount,
          ),
        ),
      ],
    );

    //  Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Text(
    //             pokemon.isCollected
    //                 ? pokemon.description.name
    //                 : '?' * pokemon.description.name.length,
    //             style: const TextStyle(
    //               fontSize: 24.0,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 8.0,
    //           ),
    //           PokemonIdTextWidget(
    //             id: pokemon.id,
    //             gridCrossAxisCount: gridCrossAxisCount,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
    //       child: Row(
    //         children: [
    //           Column(
    //             children: List.generate(
    //               pokemon.types.length,
    //               (typeIndex) => GridTypeImageWidget(
    //                 isCollected: pokemon.isCollected,
    //                 typeImageUrl:
    //                     // 'assets/images/types/fire_type.png',
    //                     'assets/images/types/${TypeEnum.values[int.parse(pokemon.types[typeIndex])].toString().split('.').last}_type.png',
    //                 typeimageSize: 32.0,
    //                 iconSize: 24.0,
    //               ),
    //             ),
    //           ),
    //           PokemonImageWidget(
    //             isCollected: pokemon.isCollected,
    //             imageurl: pokemon.imageurl,
    //             gridCrossAxisCount: gridCrossAxisCount,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
