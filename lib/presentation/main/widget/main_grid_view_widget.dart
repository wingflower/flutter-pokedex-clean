import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/widget/fifth_column_grid_view_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/fourth_column_grid_view_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/third_column_grid_view_widget.dart';

import 'two_column_grid_view_widget.dart';

enum TypeEnum {
  none,
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
}

class MainGridViewWidget extends StatelessWidget {
  const MainGridViewWidget({
    super.key,
    required this.state,
  });

  final MainState state;

  @override
  Widget build(BuildContext context) {
    List<Pokemon> pokemonList = state.pokemonListData;
    int gridCrossAxisCount = state.gridCrossAxisCount;

    gridCrossAxisCount = 3;

    return Scrollbar(
      thumbVisibility: true,
      thickness: 8.0,
      radius: const Radius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCrossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
            if (index % 4 == 0 || index % 7 == 0) {
              pokemonList[index].setIsCollected = true;
            }
            return GestureDetector(
              // onTap: () => context.go('/main/detail'),
              onTap: null,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: pokemonList[index].isCollected
                        ? _getColorFromString(pokemonList[index].color)
                        : _getColorFromString('black'),
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
