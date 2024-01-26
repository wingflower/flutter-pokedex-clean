import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/assets.dart';

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
              placeholder: (context, url) => Opacity(
                opacity: 0.5,
                child: Image.asset(
                  pokeball,
                  // color: Colors.black.withOpacity(0.6),
                  width: pokemonImageSize,
                  height: pokemonImageSize,
                ),
              ),
              // errorWidget: ,
            )
          : CachedNetworkImage(
              imageUrl: imageurl,
              width: pokemonImageSize,
              height: pokemonImageSize,
              color: Colors.black45,
            ),
    );
  }
}
