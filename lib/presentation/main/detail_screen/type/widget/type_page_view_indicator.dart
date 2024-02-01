import 'package:flutter/material.dart';

class TypePageViewIndicator extends StatefulWidget {
  final PageController pageController;
  final int itemCount;

  const TypePageViewIndicator({
    super.key,
    required this.pageController,
    required this.itemCount,
  });

  @override
  State<TypePageViewIndicator> createState() => _MyPageViewIndicatorState();
}

class _MyPageViewIndicatorState extends State<TypePageViewIndicator> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        _currentPage = widget.pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.itemCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}
