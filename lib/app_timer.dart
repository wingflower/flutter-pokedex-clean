import 'dart:async';

import 'package:flutter/material.dart';

class AppTimer extends ChangeNotifier with WidgetsBindingObserver {
  Timer? _timer;
  int _timeState = 0;
  final int _maxTimeState = 10;
  int _count = 0;
  final int _maxCount = 10;

  int get timeState => _timeState;
  int get count => _count;

  AppTimer() {
    WidgetsBinding.instance.addObserver(this);
  }

  void startTimer() {
    _timer ??= Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        timeCount();
      },
    );
  }

  void timeCount() {
    if (_timeState < _maxTimeState) {
      _timeState += 1;
      notifyListeners();
    }
    if (_timeState == _maxTimeState) {
      _timeState = 0;
      notifyListeners();
    }
    if (_timeState % _maxTimeState == 0) {
      _count += 1;
      notifyListeners();
    }

    if (_timeState < _maxTimeState) {
      _timeState += 1;
    } else {
      _timeState = 0;
      _count += 1;
    }
    notifyListeners();

    if (_count == _maxCount) {
      _timer?.cancel();
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer() {
    _timer?.cancel();
    _timer = null;
    _timeState = 0;
    _count = 0;
    notifyListeners();
  }

  void subtractCount() {
    _count -= 1;
    notifyListeners();
    _stopTimer();
    startTimer();
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
        startTimer();
      case AppLifecycleState.paused:
        _stopTimer();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
    }
    super.didChangeAppLifecycleState(state);
  }
}
