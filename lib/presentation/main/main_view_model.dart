import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/use_case/user/logout_use_case.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';

class MainViewModel extends ChangeNotifier {
  final LogoutUseCase _logoutUseCase;

  MainViewModel({required LogoutUseCase logoutUseCase}) : _logoutUseCase = logoutUseCase;

  final StreamController<MainUiEvent> _controller = StreamController();

  Stream<MainUiEvent> get stream => _controller.stream;

  Future<void> logout() async {
    final result = await _logoutUseCase.execute();
    result.when(
      success: (data) => _controller.add(const MainUiEvent.successLogout()),
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }
}
