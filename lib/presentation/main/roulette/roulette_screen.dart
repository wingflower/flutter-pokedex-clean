import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_ui_event.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_view_model.dart';
import 'package:provider/provider.dart';

class RouletteScreen extends StatefulWidget {
  final List<Pokemon> pokemonList;
  final UserInfo userInfo;
  final String email;

  const RouletteScreen({super.key, required this.pokemonList, required this.userInfo, required this.email});

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
    curve: Curves.fastOutSlowIn,
  );

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    Future.microtask(() {
      final RouletteViewModel viewModel = context.read();
      final AppTimer appTimer = context.read();
      streamSubscription = viewModel.stream.listen((event) {
        switch(event) {
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
          _animationController.reverse();
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
    final Animation<double> animationSize = Tween(begin: 1.0, end: 2.0).animate(_animationController);
    final AppTimer appTimer = context.watch();
    final bool activeButton = appTimer.count > 0;
    final RouletteViewModel viewModel = context.watch();

    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppTimer>(
          builder: (context, appTimer, child) {
            return Text('CNT: ${appTimer.count}');
          },
        ),
      ),
      body: Center(
        child: RotationTransition(
          turns: Tween<double>(begin: 0.0, end: 5.0).animate(_scaleAnimation),
          child: ScaleTransition(
            scale: animationSize,
            child: GestureDetector(
              onTap: activeButton
                  ? () {
                      if (_animationController.isDismissed || _animationController.isCompleted) {
                        _animationController.forward(from: 0.0);
                        viewModel.drawPokemon(widget.pokemonList, widget.userInfo, widget.email);
                      }
                    }
                  : null,
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
      ),
    );
  }


  void _showPokemonDialog(Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Center(child: Text("포켓몬 획득!")),
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
