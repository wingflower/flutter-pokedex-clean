import 'dart:async';
import 'package:flutter/material.dart';

class AppTimer extends ChangeNotifier with WidgetsBindingObserver {
  Timer? _timer;
  int _timeState = 0;

  int get timeState => _timeState;

  AppTimer() {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _timeState += 1;
        notifyListeners();
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
}