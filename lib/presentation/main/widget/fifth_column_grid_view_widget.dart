import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_image_widget.dart';

class FifthColumnGridViewWidget extends StatelessWidget {
  const FifthColumnGridViewWidget({
    super.key,
    required this.pokemon,
    required this.gridCrossAxisCount,
  });

  final Pokemon pokemon;
  final int gridCrossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: PokemonImageWidget(
          isCollected: pokemon.isCollected,
          isNew: pokemon.isNew,
          imageurl: pokemon.imageurl,
          gridCrossAxisCount: gridCrossAxisCount,
        ),
      ),
    );
  }
}
