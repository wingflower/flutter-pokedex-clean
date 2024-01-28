import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/assets.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

class DetailImageContainerWidget extends StatelessWidget {
  const DetailImageContainerWidget({
    super.key,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 16.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.3,
                child: Transform.scale(
                  scale: 2,
                  child: CachedNetworkImage(
                    imageUrl: pokemonData.imageurl,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(32.0),
              bottomRight: Radius.circular(32.0),
            ),
            color: getColorFromString(pokemonData.color),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
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
                        getTypeImagebyTypeId(pokemonData.types[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
