import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/assets.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

import 'widget/info_title_text_widget.dart';

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
        title: const Text('세부 정보'),
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
            Container(
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                  color: getColorFromString(pokemonData.color),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 16.0,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    // Image.network(
                    //   testData.imageurl,
                    // ),
                    CachedNetworkImage(
                      imageUrl: pokemonData.imageurl,
                      placeholder: (context, url) => Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          pokeball,
                        ),
                      ),
                      // errorWidget: ,
                    ),
                    Positioned(
                      top: 8.0,
                      right: 16.0,
                      child: Text(
                        pokemonData.id,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 16.0,
                      child: Text(
                        pokemonData.description.name,
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8.0,
                      bottom: 8.0,
                      child: Row(
                        children: List.generate(
                          pokemonData.types.length,
                          (index) => Image.asset(
                            'assets/images/types/${TypeEnum.values[int.parse(pokemonData.types[index])].toString().split('.').last}_type.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  // border: const Border(
                  //   top: BorderSide(color: Colors.black, width: 2.0),
                  // ),
                  // borderRadius: BorderRadius.circular(32.0),
                  ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InfoTitleTextWidget(title: 'About'),
                        Text(
                          pokemonData.description.flavor_text,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Column(
                      children: [
                        InfoTitleTextWidget(title: 'Stat'),
                        Text(''),
                      ],
                    ),
                    const Column(
                      children: [
                        InfoTitleTextWidget(title: 'Evolution'),
                        Column(
                          children: [
                            LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          ],
                        ),
                        Text(''),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const InfoTitleTextWidget(title: 'Type'),
                            IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          ],
                        ),
                        const Text(''),
                      ],
                    ),
                    const Column(
                      children: [
                        InfoTitleTextWidget(title: 'Against'),
                        Text(''),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
