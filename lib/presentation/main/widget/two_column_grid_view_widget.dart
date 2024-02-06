import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';
import 'package:pokedex_clean/presentation/main/widget/grid_type_image_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_id_text_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_image_widget.dart';

class TwoColumnGridViewWidget extends StatelessWidget {
  const TwoColumnGridViewWidget({
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
          isNew: pokemon.isNew,
          imageurl: pokemon.imageurl,
          gridCrossAxisCount: gridCrossAxisCount,
        ),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: Row(
            children: List.generate(
              pokemon.types.length,
              (typeIndex) => GridTypeImageWidget(
                isCollected: pokemon.isCollected,
                typeImageUrl: getTypeImagebyTypeId(pokemon.types[typeIndex]),
                typeimageSize: 48.0,
                iconSize: 24.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: Text(
            pokemon.isCollected
                ? pokemon.description.name
                : '?' * pokemon.description.name.length,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: PokemonIdTextWidget(
            id: pokemon.id,
            gridCrossAxisCount: gridCrossAxisCount,
          ),
        ),
      ],
    );
  }
}
