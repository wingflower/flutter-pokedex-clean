import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

class TypeScreen extends StatelessWidget {
  final List<TypeModel> typeList;
  const TypeScreen({
    super.key,
    required this.typeList,
  });

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
          itemCount: typeList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                typeEffectShowDialogFunction(
                  context,
                  index,
                  typeList[index],
                );
              },
              child: Image.asset(
                getTypeDoubleImagebyTypeId(typeList[index].id),
              ),
            );
          },
        ),
      ),
    );
  }
}
