import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';

import 'widget/detail_ability_column_widget.dart';
import 'widget/detail_about_column_widget.dart';
import 'widget/detail_evolution_image_widget.dart';
import 'widget/detail_image_container_widget.dart';
import 'widget/detail_info_title_text_widget.dart';
import 'widget/detail_stat_info_row_widget.dart';
import 'widget/detail_type_column_widget.dart';

class DetailScreen extends StatelessWidget {
  final MainState mainState;
  final Pokemon pokemonData;
  DetailScreen({
    super.key,
    required this.pokemonData,
    required this.mainState,
  }) {
    pokemonData.setIsNew = false;
  }

  @override
  Widget build(BuildContext context) {
    print('qwerasdf pokemonData.isNew ${pokemonData.isNew}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '#${pokemonData.id} ${pokemonData.description.name}',
        ),
        backgroundColor: getColorFromString(pokemonData.color),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailImageContainerWidget(pokemonData: pokemonData),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  // About
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const DetailInfoTitleTextWidget(title: 'About'),
                      DetailAboutColumnWidget(pokemonData: pokemonData),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  // Ability
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DetailInfoTitleTextWidget(title: '특성'),
                      DetailAbilityColumnWidget(pokemonData: pokemonData),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  // Stat
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DetailInfoTitleTextWidget(title: '스탯'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Hp
                            DetailStatInfoRowWidget(
                                infoTitle: '체력', infoFigure: pokemonData.hp),
                            // Attack
                            DetailStatInfoRowWidget(
                                infoTitle: '공격력',
                                infoFigure: pokemonData.attack),
                            // Defense
                            DetailStatInfoRowWidget(
                                infoTitle: '방어력',
                                infoFigure: pokemonData.defense),
                            // Sp.Attak
                            DetailStatInfoRowWidget(
                                infoTitle: '특수공격력',
                                infoFigure: pokemonData.special_attack),
                            //Sp.Defense
                            DetailStatInfoRowWidget(
                                infoTitle: '특수방어력',
                                infoFigure: pokemonData.special_defense),
                            //Speed
                            DetailStatInfoRowWidget(
                                infoTitle: '속도', infoFigure: pokemonData.speed),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  // Evolution
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DetailInfoTitleTextWidget(title: '진화'),
                      DetailEvolutionImageWidget(pokemonData: pokemonData),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  DetailTypeColumnWidget(
                    pokemonData: pokemonData,
                    mainState: mainState,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  // const Column(
                  //   children: [
                  //     DetailInfoTitleTextWidget(title: 'Against'),
                  //     Text(''),
                  //   ],
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
