import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_clean/core/secure_storage_key.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/domain/use_case/collection/get_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/logout_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/remove_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_ui_event.dart';

class MainViewModel extends ChangeNotifier with WidgetsBindingObserver {
  final LogoutUseCase _logoutUseCase;
  final RemoveUserAccountUseCase _removeUserAccountUseCase;
  final GetPokemonUseCase _getPokemonUseCase;

  MainViewModel({
    required LogoutUseCase logoutUseCase,
    required RemoveUserAccountUseCase removeUserAccountUseCase,
    required GetPokemonUseCase getPokemonUseCase,
  })  : _logoutUseCase = logoutUseCase,
        _getPokemonUseCase = getPokemonUseCase,
        _removeUserAccountUseCase = removeUserAccountUseCase {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  MainState _state = const MainState();
  MainState get state => _state;

  Timer? _rewardTimer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _startTimer();
      case AppLifecycleState.paused:
        _stopTimer();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
    }
    super.didChangeAppLifecycleState(state);
  }

  void _startTimer() {
    _rewardTimer?.cancel();
    _rewardTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _state = state.copyWith(rewardTime: state.rewardTime + 1);
      notifyListeners();
    });
  }

  void _stopTimer() {
    _rewardTimer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final StreamController<MainUiEvent> _controller = StreamController();

  Stream<MainUiEvent> get stream => _controller.stream;

  Future<void> logout() async {
    final result = await _logoutUseCase.execute();
    result.when(
      success: (data) async {
        await _removeUserAccountUseCase.execute(keyEmail, keyPassword);
        _controller.add(const MainUiEvent.successLogout());
      },
      error: (e) => _controller.add(MainUiEvent.showSnackBar(e)),
    );
  }

  List<Pokemon> pokemonDataList = [];

  Future<void> fetchPokemonDataList() async {
    pokemonDataList = (await _getPokemonUseCase.execute()) as List<Pokemon>;
    notifyListeners();
  }
}
