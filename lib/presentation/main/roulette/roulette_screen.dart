import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/presentation/common/assets.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_ui_event.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_view_model.dart';
import 'package:provider/provider.dart';

class RouletteScreen extends StatefulWidget {
  final List<Pokemon> pokemonList;
  final UserInfo userInfo;
  final String email;

  const RouletteScreen({
    super.key,
    required this.pokemonList,
    required this.userInfo,
    required this.email,
  });

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    Future.microtask(() {
      final RouletteViewModel viewModel = context.read();
      final AppTimer appTimer = context.read();
      streamSubscription = viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            showSnackBar(context, event.message);
          case ShowDialog():
            _showPokemonDialog(event.pokemon);
            appTimer.subtractCount();
        }
      });
    });
    super.initState();
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      },
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animationSize =
        Tween(begin: 0.8, end: 2.0).animate(_animationController);
    final AppTimer appTimer = context.watch();
    final bool activeButton = appTimer.count > 0;
    final RouletteViewModel viewModel = context.watch();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(children: [
          Image.asset(
            pokeball,
            height: 40,
            width: 40,
          ),
          Consumer<AppTimer>(
            builder: (context, appTimer, child) {
              return Text(
                'X ${appTimer.count}',
              );
            },
          ),
        ]),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(rouletteBackGroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(_scaleAnimation),
            child: ScaleTransition(
              scale: animationSize,
              child: GestureDetector(
                onTap: activeButton
                    ? () {
                        if (_animationController.isDismissed ||
                            _animationController.isCompleted) {
                          _animationController.forward(from: 0.0);
                          viewModel.drawPokemon(widget.pokemonList,
                              widget.userInfo, widget.email);
                        }
                      }
                    : null,
                child: ShakeAnimatedWidget(
                  enabled: appTimer.count >= 1,
                  duration: const Duration(seconds: 2),
                  shakeAngle: Rotation.deg(z: 15),
                  curve: Curves.linearToEaseOut,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(pokeball),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPokemonDialog(Pokemon pokemon) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: Text(
            '${pokemon.description.name}[${pokemon.id}] 획득!',
          ),
        ),
        content: Image.network(
          pokemon.imageurl,
          height: 400,
          width: 400,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}
