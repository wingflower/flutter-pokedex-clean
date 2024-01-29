import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

class DetailAbilityColumnWidget extends StatelessWidget {
  const DetailAbilityColumnWidget({
    super.key,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(pokemonData.abilities.length, (index) {
          return GestureDetector(
            onTap: () => print(
              'qwerasdf ${pokemonData.abilities[index].ability_id}',
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemonData.abilities[index].name,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    '- ${pokemonData.abilities[index].flavor_text}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
