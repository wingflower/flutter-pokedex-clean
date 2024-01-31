import 'package:flutter/material.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> typeTest = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
    ];
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
          itemCount: typeTest.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Image.asset(
                getTypeDoubleImagebyTypeId(typeTest[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
