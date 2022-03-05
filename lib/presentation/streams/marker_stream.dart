import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerStream {
  final StreamController<BitmapDescriptor?> _controller =
      StreamController<BitmapDescriptor?>.broadcast();
  StreamSink<BitmapDescriptor?> get sink => _controller.sink;
  Stream<BitmapDescriptor?> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
