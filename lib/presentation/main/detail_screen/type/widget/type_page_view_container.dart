import 'package:flutter/material.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';

class TypePageViewContainer extends StatelessWidget {
  const TypePageViewContainer({
    super.key,
    required this.title,
    required this.typeList,
    required this.color,
  });

  final String title;
  final List<String> typeList;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Scrollbar(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: typeList.length,
                itemBuilder: (context, index) => Image.asset(
                  getTypeImagebyTypeId(
                    typeList[index],
                  ),
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
