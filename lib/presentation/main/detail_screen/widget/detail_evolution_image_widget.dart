import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/assets.dart';

class DetailEvolutionImageWidget extends StatelessWidget {
  const DetailEvolutionImageWidget({
    super.key,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          pokemonData.evolutions.length,
          (index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print('qwerasdf ${pokemonData.evolutions[index]}');
                  },
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${int.parse(pokemonData.evolutions[index])}.png',
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                    placeholder: (context, url) => Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        pokeball,
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                      ),
                    ),
                    // errorWidget: ,
                  ),
                ),
                if (index != pokemonData.evolutions.length - 1)
                  const Icon(
                    Icons.arrow_right_rounded,
                    size: 24.0,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
