import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

import './../../../../domain/all.dart';

class ZoomScreen extends StatelessWidget {
  final String image;
  const ZoomScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenback,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: primarycol,
      ),
      body: Zoom(
        backgroundColor: screenback,
        canvasColor: screenback,
        maxZoomWidth: 1800,
        maxZoomHeight: 1800,
        initZoom: 0.0,
        child: Center(
          child: CustomNetworkImage(image: image),
        ),
      ),
    );
  }
}
