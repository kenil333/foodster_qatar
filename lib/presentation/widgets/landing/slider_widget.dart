import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import './../../../domain/all.dart';

class SliderWidget extends StatefulWidget {
  final Size size;
  final List<BannerModel> banners;
  const SliderWidget({
    Key? key,
    required this.size,
    required this.banners,
  }) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final _intstream = IntStream();

  @override
  void dispose() {
    _intstream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _intstream.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return Column(
          children: [
            const SizedBox(height: 5),
            CarouselSlider(
              items: widget.banners.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: widget.size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomNetworkImage(image: i.image!),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: widget.size.height * 0.28,
                autoPlay: true,
                aspectRatio: 1.0,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  _intstream.sink.add(index);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.banners.map(
                (ib) {
                  int index = widget.banners.indexOf(ib);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: snapshot.data == index
                          ? primarycol
                          : primarycol.withOpacity(0.3),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
