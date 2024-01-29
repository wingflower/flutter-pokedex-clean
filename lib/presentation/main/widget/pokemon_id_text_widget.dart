import 'package:flutter/material.dart';

class PokemonIdTextWidget extends StatelessWidget {
  final String id;
  final int gridCrossAxisCount;

  const PokemonIdTextWidget({
    super.key,
    required this.id,
    required this.gridCrossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    double idContainerWidth = 64.0 - gridCrossAxisCount * 6.0;
    double idTextSize = 20.0 - (gridCrossAxisCount * 2.0);

    return Container(
      width: idContainerWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        id,
        style: TextStyle(
          fontSize: idTextSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
