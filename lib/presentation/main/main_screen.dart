import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/presentation/common/assets.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

import 'widget/main_grid_view_widget.dart';
import 'widget/user_sort_option_elevated_button_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final TextEditingController _textEditingController =
      TextEditingController();

  late final StreamController<double> _sliderValueStreamController =
      StreamController<double>.broadcast();
  late final StreamController<List<bool>> _collectionOptionStreamController =
      StreamController<List<bool>>.broadcast();
  late final StreamController<List<bool>> _directionOptionStreamController =
      StreamController<List<bool>>.broadcast();

  @override
  void initState() {
    Future.microtask(() {
      final MainViewModel viewModel = context.read();
      final AppTimer appTimer = context.read();
      viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            showSnackBar(context, event.message);
          case SuccessLogout():
            appTimer.resetTimer();
            showSimpleDialog(
              context,
              title: '로그아웃 성공',
              content: '다음에 또 만나요~!',
              isVisibleCancelButton: false,
              cancelable: false,
              confirmAction: () => context.go('/login'),
            );
          case ErrorInitialize():
            showSimpleDialog(
              context,
              title: '오류',
              content: event.message,
              isVisibleCancelButton: false,
              cancelable: false,
              confirmAction: () => context.go('/login'),
            );
        }
      });
      appTimer.startTimer();
      _textEditingController.addListener(() {
        viewModel.searchPokemon(_textEditingController.text);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    _sliderValueStreamController.close();
    _collectionOptionStreamController.close();
    _directionOptionStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppTimer timer = context.watch();
    final MainViewModel viewModel = context.watch();
    final MainState state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: '이름 검색',
            prefixIcon: const Icon(Icons.search_outlined),
            suffixIcon: Visibility(
              visible: _textEditingController.text.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: _textEditingController.clear,
              ),
            ),
          ),
        ),
        actions: [
          UserSortOptionElevatedButtonWidget(
            mainViewModel: viewModel,
            sliderValueStreamController: _sliderValueStreamController,
            collectionOptionStreamController: _collectionOptionStreamController,
            directionOptionStreamController: _directionOptionStreamController,
          ),
          IconButton(
              onPressed: () {
                showSimpleDialog(
                  context,
                  title: '로그아웃',
                  content: '로그아웃 하시겠습니까?',
                  confirmAction: viewModel.logout,
                );
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: state.isLoading
          ? Center(
              child: Lottie.asset(squirtleJson,
                  width: MediaQuery.of(context).size.width / 2),
            )
          : MainGridViewWidget(
              state: state,
              onTap: (pokemon) async {
                if (!pokemon.isCollected) {
                  showSimpleDialog(
                    context,
                    title: '안내',
                    content: '${'?' * pokemon.description.name.length} 은(는) 미보유 상태입니다.',
                    isVisibleCancelButton: false
                  );
                }
                else {
                  await context.push('/main/detail', extra: {
                    'pokemonList': pokemon,
                    'mainState': state,
                  });
                  viewModel.markItemAsSeen(pokemon);
                }
              },
            ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.lightBlueAccent.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Image.asset(
              pokeball,
              width: 60,
            ),
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  timer.count.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: timer.count < 10 ? 16 : 14),
                ),
              ),
            ),
          ],
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shake(duration: const Duration(seconds: 1), hz: timer.count / 2),
        onPressed: () async {
          await context.push(
            '/main/roulette',
            extra: {
              'pokemonData': state.pokemonListData,
              'userInfo': state.userInfo,
              'email': state.email,
            },
          );
          viewModel.refresh();
        },
      ),
    );
  }
}
