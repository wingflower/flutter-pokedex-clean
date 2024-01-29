import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_id_text_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_image_widget.dart';

class ThirdColumnGridViewWidget extends StatelessWidget {
  const ThirdColumnGridViewWidget({
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
          top: 8.0,
          left: 8.0,
          child: Text(
            pokemon.isCollected
                ? pokemon.description.name
                : '?' * pokemon.description.name.length,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
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
