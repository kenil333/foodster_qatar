import 'dart:async';

import './../../domain/all.dart';

class ListRestoStream {
  final StreamController<List<ResturantModel>> _controller =
      StreamController<List<ResturantModel>>();
  StreamSink<List<ResturantModel>> get sink => _controller.sink;
  Stream<List<ResturantModel>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
