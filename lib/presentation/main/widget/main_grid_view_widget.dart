import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/widget/fifth_column_grid_view_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/fourth_column_grid_view_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/third_column_grid_view_widget.dart';

import 'two_column_grid_view_widget.dart';

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

    List<String> collectionList = [
      "0001",
      "0002",
      "0003",
      "0004",
      "0005",
      "0006",
      "0007",
      "0008",
      "0009",
      "0025",
    ];

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
          // pokemonList[index].setIsCollected = true;
          // if (index != 0 && index % 2 == 0 || index > 10) {
          //   pokemonList[index].setIsCollected = false;
          // }
          for (int i = 0; i < collectionList.length; i++) {
            if (pokemonList[index].id == collectionList[i]) {
              pokemonList[index].setIsCollected = true;
              // print('qwerasdf ${pokemonList[index].description.name}');
            }
          }
          return GestureDetector(
            onTap: () => pokemonList[index].isCollected
                ? context.push('/main/detail', extra: pokemonList[index])
                : showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('안내'),
                        content: Text(
                            '${'?' * pokemonList[index].description.name.length} 은(는) 미보유 상태입니다.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    },
                  ),
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
                            ),
            ),
          );
        },
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
