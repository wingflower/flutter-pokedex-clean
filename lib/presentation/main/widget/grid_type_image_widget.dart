import 'package:flutter/material.dart';

class GridTypeImageWidget extends StatelessWidget {
  final bool isCollected;
  final String typeImageUrl;
  final double typeimageSize;
  final double iconSize;
  const GridTypeImageWidget({
    super.key,
    required this.isCollected,
    required this.typeImageUrl,
    required this.typeimageSize,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: isCollected
          ? Image.asset(
              typeImageUrl,
              width: typeimageSize,
              height: typeimageSize,
            )
          : null,
    );
  }
}
