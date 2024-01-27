import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/common.dart';

import 'widget/detail_about_column_widget.dart';
import 'widget/detail_evolution_image_widget.dart';
import 'widget/detail_image_container_widget.dart';
import 'widget/detail_info_title_text_widget.dart';
import 'widget/detail_stat_info_row_widget.dart';
import 'widget/detail_type_column_widget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Pokemon pokemonData;
    if (GoRouterState.of(context).extra != null) {
      pokemonData = GoRouterState.of(context).extra! as Pokemon;
    } else {
      throw Exception(e);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '#${pokemonData.id} ${pokemonData.description.name}',
        ),
        backgroundColor: getColorFromString(pokemonData.color),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline,
              size: 32.0,
            ),
          ),
        ],
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(pokemonData.abilities.length,
                              (index) {
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
                      ),
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
                  DetailTypeColumnWidget(pokemonData: pokemonData),
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
