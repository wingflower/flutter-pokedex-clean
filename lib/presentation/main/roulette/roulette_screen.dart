import 'package:flutter/material.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:provider/provider.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animationSize = Tween(begin: 0.5, end: 2.0).animate(_animationController);

    AppTimer appTimer = context.watch();

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
                child: Center(
                  child: Text(_calculateTime(appTimer.timeState)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
              ),
              Container(
                width: 250,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text('뽑기 횟수'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
              ),
              RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 10.0).animate(_scaleAnimation),
                child: ScaleTransition(
                  scale: animationSize,
                  child: GestureDetector(
                    onTap: () {
                      _animationController.forward(from: 0.0);
                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateTime(int rewardTime) {
    int minutes = rewardTime ~/ 60;
    int seconds = rewardTime % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
