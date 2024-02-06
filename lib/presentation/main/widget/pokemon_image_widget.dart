import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/presentation/common/assets.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    super.key,
    required this.isCollected,
    required this.isNew,
    required this.imageurl,
    required this.gridCrossAxisCount,
  });

  final bool isCollected;
  final bool isNew;
  final String imageurl;
  final int gridCrossAxisCount;

  @override
  Widget build(BuildContext context) {
    double pokemonImageSize = 154.0;
    switch (gridCrossAxisCount) {
      case 2:
        pokemonImageSize =
            ((MediaQuery.of(context).size.width / gridCrossAxisCount)
                  ..toStringAsFixed(2)) -
                24.0;
        break;
      case 3:
        pokemonImageSize =
            ((MediaQuery.of(context).size.width / gridCrossAxisCount)
                  ..toStringAsFixed(2)) -
                24.0;
        break;
      case 4:
        pokemonImageSize =
            ((MediaQuery.of(context).size.width / gridCrossAxisCount)
                  ..toStringAsFixed(2)) -
                8.0;
        break;
      case 5:
        pokemonImageSize =
            ((MediaQuery.of(context).size.width / gridCrossAxisCount)
                  ..toStringAsFixed(2)) -
                8.0;
        break;
      default:
        pokemonImageSize = 50.0;
        break;
    }
    return Container(
      alignment: Alignment.center,
      decoration: isNew
          ? BoxDecoration(
              border: Border.all(
                  strokeAlign: BorderSide.strokeAlignInside,
                  color: Colors.red.withOpacity(0.8),
                  width: 4),
              borderRadius: BorderRadius.circular(10.0),
            )
          : null,
      child: isCollected
          ? CachedNetworkImage(
              imageUrl: imageurl,
              width: pokemonImageSize,
              height: pokemonImageSize,
              placeholder: (context, url) => Opacity(
                opacity: 0.5,
                child: Image.asset(
                  pokeball,
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
