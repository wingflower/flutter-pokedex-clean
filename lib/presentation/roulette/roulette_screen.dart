import 'package:flutter/material.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.decelerate,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animationSize = Tween(begin: 0.5, end: 1.0).animate(_animationController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('뽑기'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(child: Text('타이머')),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(child: Text('뽑기 횟수')),
              ),
              const Padding(padding: EdgeInsets.all(16)),
              RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 5.0).animate(_scaleAnimation),
                child: ScaleTransition(
                  scale: animationSize,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/pokeball/pokeball.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  // 앱 접속 후 최초 1회 활성화, 뽑기 실시 후 횟수 소진 시 비활성, 누르면 타이머 초기화 시키기
                  onPressed: () {
                    _animationController.forward(from: 0.0);
                  },
                  child: const Text(
                    '뽑기',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
