import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';

class TimerInfoTile extends ConsumerWidget {
  final int crossAxisCellCount;
  final num mainAxisCellCount;
  final Widget child;
  final TimerTileStyle style;
  final Widget header;

  const TimerInfoTile( {required this.child, required this.crossAxisCellCount, required this.mainAxisCellCount, required this.style, required this.header });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount,
      mainAxisCellCount: mainAxisCellCount,
      child: Padding(
        padding: style.padding,
        child: Container(
          decoration: BoxDecoration(
              color: style.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              Expanded(child : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  child,
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
