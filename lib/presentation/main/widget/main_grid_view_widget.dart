import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
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
    List<Pokemon> pokemonList = state.filterListData;
    int gridCrossAxisCount = state.gridCrossAxisCount;

    return RawScrollbar(
      thickness: 8.0,
      interactive: true,
      trackVisibility: true,
      thumbVisibility: true,
      thumbColor: Colors.grey.withOpacity(0.7),
      radius: const Radius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCrossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
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
                      ? getColorFromString(pokemonList[index].color)
                      : getColorFromString('black'),
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
      ),
    );
  }
}
