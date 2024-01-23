import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/presentation/common.dart';
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
              isVisibleCancelButton: true,
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
    return Scaffold(
      appBar: AppBar(
        actions: [
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
      body: Center(
        child: Text('Main화면'),
      ),
    );
  }
}
