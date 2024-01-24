import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/presentation/common.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

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
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MainViewModel viewModel = context.watch();
    final MainState state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        title: Text(_calculateTime(state.rewardTime)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.access_time),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(onPressed: () {
            showSimpleDialog(
              context,
              title: '로그아웃',
              content: '로그아웃 하시겠습니까?',
              confirmAction: viewModel.logout,
            );
          }, icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.push('/main/detail');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.bolt_outlined),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SpeedDialChild(
            child: const Icon(Icons.sort_by_alpha),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
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
