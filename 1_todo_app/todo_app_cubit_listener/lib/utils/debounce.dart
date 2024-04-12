import 'dart:async';

import 'package:flutter/material.dart';

/// Debounce는 여러번 실행되는 이벤트에서 마지막 이벤트만 실행되게 하는 것
/// 상반되는 개념으로 Throttle(여러번 발생하는 이벤트를 일정시간동안 한 번만 실행시킴)이 있다.
class Debounce {
  final int milliseconds;

  Debounce({
    this.milliseconds = 500,
  });

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    
    _timer = Timer(
      Duration(milliseconds: this.milliseconds),
      action
    );
  }
}