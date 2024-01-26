import 'package:flutter/material.dart';

class InfoTitleTextWidget extends StatelessWidget {
  final String title;
  const InfoTitleTextWidget({
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
