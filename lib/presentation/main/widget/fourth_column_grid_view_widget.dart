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
  }
}
