import 'dart:async';

class IntStream {
  final StreamController<int> _intcontroller =
      StreamController<int>.broadcast();
  StreamSink<int> get sink => _intcontroller.sink;
  Stream<int> get stream => _intcontroller.stream;

  void dispose() {
    _intcontroller.close();
  }
}
