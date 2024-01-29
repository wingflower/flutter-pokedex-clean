import 'package:flutter/material.dart';

class DetailInfoTitleTextWidget extends StatelessWidget {
  final String title;
  const DetailInfoTitleTextWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
