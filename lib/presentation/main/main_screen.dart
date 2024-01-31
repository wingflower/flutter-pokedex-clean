import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
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
      viewModel.stream.listen((event) {
        switch (event) {
          case ShowSnackBar():
            showSnackBar(context, event.message);
          case SuccessLogout():
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
    print('qwerasdf _sliderValueStreamController close');
    _collectionOptionStreamController.close();
    print('qwerasdf _collectionOptionStreamController close');
    _directionOptionStreamController.close();
    print('qwerasdf _directionOptionStreamController close');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: MainGridViewWidget(state: state),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          // SpeedDialChild(
          //   label: !state.sortDirection ? '정방향' : '역방향',
          //   child: state.sortDirection
          //       ? const Icon(Icons.upload)
          //       : const Icon(Icons.download),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(50),
          //   ),
          //   onTap: () {
          //     viewModel.sortedByOptionPokemonList('direction');
          //   },
          // ),
          // SpeedDialChild(
          //   label: '컬렉션만',
          //   child: !state.sortIsCollected
          //       ? const Icon(Icons.check_box_outline_blank_outlined)
          //       : const Icon(Icons.check_box_outlined),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(50),
          //   ),
          //   onTap: () {
          //     viewModel.sortedByOptionPokemonList('collected');
          //   },
          // ),
          SpeedDialChild(
            child: const Icon(Icons.circle_outlined),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onTap: () {
              context.push('/main/roulette');
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.star_border_outlined),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTime(int rewardTime) {
    int minutes = rewardTime ~/ 60;
    int seconds = rewardTime % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
