import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/presentation/common/common.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

import 'widget/main_grid_view_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      viewModel.fetchPokemonDataList();
      appTimer.startTimer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainViewModel viewModel = context.watch();
    final MainState state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppTimer>(
          builder: (context, appTimer, child) {
            return Text('CNT: ${appTimer.count}');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.access_time),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
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
      body: MainGridViewWidget(state: viewModel.state),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            label: !state.sortDirection ? '정방향' : '역방향',
            child: state.sortDirection
                ? const Icon(Icons.upload)
                : const Icon(Icons.download),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onTap: () {
              viewModel.sortPokemonDataList('direction');
            },
          ),
          SpeedDialChild(
            label: '컬렉션만',
            child: !state.sortIsCollected
                ? const Icon(Icons.check_box_outline_blank_outlined)
                : const Icon(Icons.check_box_outlined),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onTap: () {
              viewModel.sortPokemonDataList('collected');
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.circle_outlined),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
              onTap: () {
                context.push('/main/roulette', extra: state.pokemonListData);
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
}
