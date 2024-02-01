import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/model/user_info.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_ui_event.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_view_model.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_id_text_widget.dart';
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
    final Animation<double> animationSize = Tween(begin: 0.8, end: 2.0).animate(_animationController);
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
            'assets/images/pokeball/pokeball.png',
            height: 40,
            width: 40,
          ),
          Consumer<AppTimer>(
            builder: (context, appTimer, child) {
              return Text('X ${appTimer.count}');
            },
          ),
        ]),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/pokeball/grassland.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(_scaleAnimation),
            child: ScaleTransition(
              scale: animationSize,
              child: GestureDetector(
                onTap: () {
                      if(!activeButton) {
                        showSnackBar(context, '남은 포켓볼이 없습니다');
                        return;
                      }
                      if (_animationController.isDismissed || _animationController.isCompleted) {
                        _animationController.forward(from: 0.0);
                        viewModel.drawPokemon(widget.pokemonList, widget.userInfo, widget.email);
                      }
                  },
                child: ShakeAnimatedWidget(
                  enabled: appTimer.count >= 1,
                  duration: const Duration(seconds: 2),
                  shakeAngle: Rotation.deg(z: 15),
                  curve: Curves.linearToEaseOut,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/pokeball/pokeball.png'),
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
    double width = MediaQuery.of(context).size.width;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => GestureDetector(
        onTap: context.pop,
        child: AlertDialog(
          scrollable: true,
          title: Center(
            child: Text(
              '${pokemon.description.name} 획득!',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PokemonIdTextWidget(
                id: pokemon.id,
                gridCrossAxisCount: 1,
              ),
              Image.network(
                pokemon.imageurl,
                width: width,
                height: width,
              ),
              if (pokemon.description.flavor_text.isNotEmpty)
                Text(pokemon.description.flavor_text, style: const TextStyle(fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}
