import 'dart:async';

import './../../domain/all.dart';

class ListDishStream {
  final StreamController<List<DishModel>> _controller =
      StreamController<List<DishModel>>();
  StreamSink<List<DishModel>> get sink => _controller.sink;
  Stream<List<DishModel>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
