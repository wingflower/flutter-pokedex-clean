import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    super.key,
    required this.isCollected,
    required this.pokemonImageSize,
    required this.imageurl,
  });

  final bool isCollected;
  final double pokemonImageSize;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: isCollected
          ? CachedNetworkImage(
              imageUrl: imageurl,
              width: pokemonImageSize,
              height: pokemonImageSize,
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: imageurl,
                  width: pokemonImageSize,
                  height: pokemonImageSize,
                  color: Colors.black45,
                ),
                const Icon(
                  Icons.question_mark_rounded,
                  size: 32.0,
                  color: Colors.black45,
                ),
              ],
            ),
    );
  }
}
