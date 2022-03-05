import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './../../../domain/all.dart';

class FilterDilog extends StatefulWidget {
  final Size size;
  final String title;
  final List<String> filterlits;
  final String initialvalue;
  final Function onok;
  final String btntxt;
  const FilterDilog({
    Key? key,
    required this.size,
    required this.title,
    required this.filterlits,
    required this.initialvalue,
    required this.onok,
    required this.btntxt,
  }) : super(key: key);

  @override
  State<FilterDilog> createState() => _FilterDilogState();
}

class _FilterDilogState extends State<FilterDilog> {
  final _selected = StringStream();

  @override
  void dispose() {
    _selected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.size.width * 0.025,
          vertical: 10,
        ),
        child: StreamBuilder<String>(
          stream: _selected.stream,
          initialData: widget.initialvalue,
          builder: (context, selsnap) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: txtcol,
                      fontSize: widget.size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    for (int i = 0; i < widget.filterlits.length; i++)
                      InkWell(
                        onTap: () {
                          _selected.sink.add(widget.filterlits[i]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.size.width * 0.04,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                widget.filterlits[i] == selsnap.data
                                    ? checksvg
                                    : unchecksvg,
                                width: widget.size.width * 0.065,
                                color: txtcol,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.filterlits[i],
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: txtcol,
                                    fontSize: widget.size.width * 0.045,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: Container()),
                    CustomHalfButon(
                      size: widget.size,
                      title: widget.btntxt,
                      onclick: () {
                        widget.onok(selsnap.data!);
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
