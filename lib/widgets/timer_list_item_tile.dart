import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';

class TimerListItemTile extends ConsumerWidget {
  final String title;
  final int crossAxisCellCount;
  final num mainAxisCellCount;
  final Widget child;
  final TimerTileStyle style;

  const TimerListItemTile( {required this.title,required this.child, required this.crossAxisCellCount, required this.mainAxisCellCount, required this.style});

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
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: style.textColor),
              ),
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
