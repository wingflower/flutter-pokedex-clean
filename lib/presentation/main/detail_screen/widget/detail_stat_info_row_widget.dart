import 'package:flutter/material.dart';

class DetailStatInfoRowWidget extends StatelessWidget {
  final String infoTitle;
  final String infoFigure;

  const DetailStatInfoRowWidget({
    super.key,
    required this.infoTitle,
    required this.infoFigure,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: Row(
        children: [
          Expanded(
            child: Text(
              infoTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              infoFigure,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 180.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        20.0,
                      ),
                    ),
                    color: Colors.grey.withOpacity(0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4.0,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: double.parse(infoFigure),
                    height: 8.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20.0,
                        ),
                      ),
                      color: Colors.blue.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
