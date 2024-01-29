import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/widget/fifth_column_grid_view_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/fourth_column_grid_view_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/third_column_grid_view_widget.dart';

import 'two_column_grid_view_widget.dart';

import '../../common/type_enum.dart';

class MainGridViewWidget extends StatelessWidget {
  const MainGridViewWidget({
    super.key,
    required this.state,
  });

  final MainState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          pokemonList[index].setIsCollected = true;
          return GestureDetector(
            onTap: () => context.go('/main/detail', extra: pokemonList[index]),
            // onTap: () => context.go(Uri(
            //         path: '/main/detail',
            //         queryParameters: {'pokemonData': pokemonList[index]})
            //     .toString()),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: pokemonList[index].isCollected
                    ? _getColorFromString(pokemonList[index].color)
                    : _getColorFromString('black'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          pokemonList[index].isCollected
                              ? pokemonList[index].description.name
                              : '?' *
                                  pokemonList[index].description.name.length,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 32.0,
                        ),
                        PokemonIdTextWidget(
                          id: pokemonList[index].id,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        Column(
                          children: List.generate(
                            pokemonList[index].types.length,
                            (typeIndex) => GridTypeImageWidget(
                              isCollected: pokemonList[index].isCollected,
                              typeImageUrl: getTypeImagebyTypeId(
                                  pokemonList[index].types[typeIndex]),
                              typeimageSize: 32.0,
                              iconSize: 24.0,
                            ),
                          ),
                        ),
                        PokemonImageWidget(
                          isCollected: pokemonList[index].isCollected,
                          pokemonImageSize: 152.0,
                          imageurl: pokemonList[index].imageurl,
                        ),
                      ],
                    ),
                  ),
                  child: gridCrossAxisCount == 2
                      ? TwoColumnGridViewWidget(
                          pokemon: pokemonList[index],
                          gridCrossAxisCount: gridCrossAxisCount,
                        )
                      : gridCrossAxisCount == 3
                          ? ThirdColumnGridViewWidget(
                              pokemon: pokemonList[index],
                              gridCrossAxisCount: gridCrossAxisCount,
                            )
                          : gridCrossAxisCount == 4
                              ? FourthColumnGridViewWidget(
                                  pokemon: pokemonList[index],
                                  gridCrossAxisCount: gridCrossAxisCount,
                                )
                              : FifthColumnGridViewWidget(
                                  pokemon: pokemonList[index],
                                  gridCrossAxisCount: gridCrossAxisCount,
                                )),
            );
          },
        ),
      ),
    );
  }

  Color _getColorFromString(String colorString) {
    // {'white', 'yellow', 'green', 'purple', 'brown', 'red', 'black', 'blue', 'gray', 'pink'}
    switch (colorString) {
      case 'white':
        return Colors.white.withOpacity(0.3);
      case 'yellow':
        return Colors.yellow.withOpacity(0.3);
      case 'green':
        return Colors.green.withOpacity(0.3);
      case 'purple':
        return Colors.purple.withOpacity(0.3);
      case 'brown':
        return Colors.brown.withOpacity(0.3);
      case 'red':
        return Colors.red.withOpacity(0.3);
      case 'black':
        return Colors.black.withOpacity(0.3);
      case 'blue':
        return Colors.blue.withOpacity(0.3);
      case 'gray':
        return Colors.grey.withOpacity(0.3);
      case 'pink':
        return Colors.pink.withOpacity(0.3);
      default:
        return Colors.transparent; // 기본값 설정
    }
  }
}
