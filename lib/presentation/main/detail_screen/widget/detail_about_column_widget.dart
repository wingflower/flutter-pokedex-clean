import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

class DetailAboutColumnWidget extends StatelessWidget {
  const DetailAboutColumnWidget({
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
        children: [
          Text(
            pokemonData.description.flavor_text,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '키 : ${(int.parse(pokemonData.height) * 0.1).toStringAsFixed(1)} m',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '무게 : ${(int.parse(pokemonData.weight) * 0.1).toStringAsFixed(1)} kg',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
