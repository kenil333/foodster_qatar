import 'dart:async';

class BoolStream {
  final StreamController<bool> _boolcontroller = StreamController<bool>();
  StreamSink<bool> get sink => _boolcontroller.sink;
  Stream<bool> get stream => _boolcontroller.stream;

  void dispose() {
    _boolcontroller.close();
  }
}
