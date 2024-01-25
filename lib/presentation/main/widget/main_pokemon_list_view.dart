import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';

class MainPokemonListView extends StatelessWidget {
  final MainState state;

  const MainPokemonListView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    List<Pokemon> pokemonList = state.pokemonListData;
    print('qwerasdf MainPokemonListView ${pokemonList.length}');
    return ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.black54,
                  width: 0.5,
                ),
              ),
            ),
            height: 80.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.network(
                          pokemonList[index].imageurl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'No.0001',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 32.0,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 32.0,
                                ),
                                Text(
                                  '이상해씨',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
