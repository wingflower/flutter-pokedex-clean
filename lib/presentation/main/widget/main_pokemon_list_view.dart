import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';

class MainPokemonListView extends StatelessWidget {
  final List<Pokemon> pokemonDataList;

  const MainPokemonListView({
    super.key,
    required this.pokemonDataList,
  });

  @override
  Widget build(BuildContext context) {
    print('list length ${pokemonDataList.length}');
    return ListView.builder(
        itemCount: pokemonDataList.length,
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
                          pokemonDataList[index].imageurl,
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
                      SizedBox(
                        width: 80.0,
                        child: Row(
                          children: List.generate(
                            pokemonDataList[index].types.length,
                            (typeIndex) =>
                                Text(pokemonDataList[index].types[typeIndex]),
                            // Image.asset(
                            //   '${pokemonDataList[index].types[typeIndex]}',
                            //   width: 40.0,
                            //   height: 60.0,
                            // ),
                          ),
                          // [
                          //     // pokemonDataList[index].types
                          //   Image.asset(
                          //     'assets/images/types/grass_type.png',
                          //     width: 40.0,
                          //     height: 60.0,
                          //   ),
                          //   Image.asset(
                          //     'assets/images/types/poison_type.png',
                          //     width: 40.0,
                          //     height: 60.0,
                          //   ),
                          // ],
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
