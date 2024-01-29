import 'package:flutter/material.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

class TypePageViewContainer extends StatelessWidget {
  const TypePageViewContainer({
    super.key,
    required this.title,
    required this.goodForType,
    required this.color,
  });

  final String title;
  final List<String> goodForType;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            Column(
              children: List.generate(goodForType.length, (index) {
                return Image.asset(
                  getTypeImagebyTypeId(goodForType[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
