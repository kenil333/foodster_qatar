import 'dart:async';

import './../../domain/all.dart';

class SearchStream {
  final StreamController<List<SearchModel>> _controller =
      StreamController<List<SearchModel>>();
  StreamSink<List<SearchModel>> get sink => _controller.sink;
  Stream<List<SearchModel>> get stream => _controller.stream;

  dispose() => _controller.close();
}
