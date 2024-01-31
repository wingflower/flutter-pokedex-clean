import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';
import 'package:pokedex_clean/presentation/main/detail_screen/widget/detail_info_title_text_widget.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';

class DetailTypeColumnWidget extends StatefulWidget {
  final MainState mainState;
  const DetailTypeColumnWidget({
    super.key,
    required this.mainState,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  State<DetailTypeColumnWidget> createState() => _DetailTypeColumnWidgetState();
}

class _DetailTypeColumnWidgetState extends State<DetailTypeColumnWidget> {
  // late PageController _pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(initialPage: 0);
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    List<TypeModel> typeList = widget.mainState.typeList;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Type
            const DetailInfoTitleTextWidget(title: '타입'),
            IconButton(
              onPressed: () {
                context.push('/main/type', extra: typeList);
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ],
        ),
        Row(
          children: List.generate(
            widget.pokemonData.types.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  TypeModel typeModel = typeList.firstWhere((element) =>
                      element.id == widget.pokemonData.types[index]);
                  typeEffectShowDialogFunction(
                    context,
                    index,
                    typeModel,
                    // _pageController,
                  );
                },
                child: Image.asset(
                  getTypeImagebyTypeId(
                    widget.pokemonData.types[index],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
