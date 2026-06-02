import 'dart:async';

class DebounceHelper {
  final Duration delay;

  Timer? _timer;

  DebounceHelper({this.delay = const Duration(milliseconds: 400)});

  void call(void Function() action) {
    _timer?.cancel();

    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
