import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

class TypeScreen extends StatefulWidget {
  final List<TypeModel> typeList;
  const TypeScreen({
    super.key,
    required this.typeList,
  });

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '타입 효과',
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            crossAxisCount: 3,
          ),
          itemCount: widget.typeList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                typeEffectShowDialogFunction(
                  context,
                  index,
                  widget.typeList[index],
                  // _pageController,
                );
              },
              child: Image.asset(
                getTypeDoubleImagebyTypeId(widget.typeList[index].id),
              ),
            );
          },
        ),
      ),
    );
  }
}
