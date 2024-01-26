import 'package:flutter/material.dart';

class PokemonIdTextWidget extends StatelessWidget {
  final String id;

  const PokemonIdTextWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        id,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
