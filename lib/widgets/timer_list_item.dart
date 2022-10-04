import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/widgets/timer_list_item_tile.dart';

import '../models/timer_model.dart';
import '../providers/providers.dart';
import '../screens/timer_screen.dart';
import '../utilities/localizations.dart';
import 'expanded_test_button.dart';

class TimerListItem extends ConsumerWidget {
  final TimerModel timer;

  TimerListItem(this.timer);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: ExpansionTile(
        collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        collapsedIconColor: Theme.of(context).colorScheme.primary,
        iconColor: Theme.of(context).colorScheme.primary,
        title: Text(
          timer.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        children: <Widget>[
          StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: [
              TimerListItemTile(
                title: AppLocalizations.intervals,
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _buildIntervals(context),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(left: 10, right: 5),
              ),
              TimerListItemTile(
                title: AppLocalizations.setsReps,
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Text(
                  timer.sets.toString() + 'x' + timer.reps.toString() ,
                  style: Theme.of(context).textTheme.headline6,
                ),
                padding: EdgeInsets.only(right: 10, left: 5),
              ),
              timer.rest != 0 ? TimerListItemTile(
                title: AppLocalizations.rest,
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Text(
                  timer.rest.toString() + 's',
                  style: Theme.of(context).textTheme.headline6,
                ),
                padding: EdgeInsets.all(10),
              ) : SizedBox(),
              // TimerListItemTile(
              //   title: AppLocalizations.totalTime,
              //   crossAxisCellCount: 1,
              //   mainAxisCellCount: 1,
              //   child: Text(
              //     timer.getTotalSeconds().toString() + 's',
              //     style: Theme.of(context).textTheme.headline6,
              //   ),
              //   padding: EdgeInsets.all(10),),
              // TimerListItemTile(
              //   title: AppLocalizations.intervals,
              //   crossAxisCellCount: 2,
              //   mainAxisCellCount: 1,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: _buildIntervals(context),
              //   ),
              //   padding: EdgeInsets.all(10),
              // ),
              StaggeredGridTile.count(
                crossAxisCellCount: timer.rest > 0 ?  2 : 3,
                mainAxisCellCount: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ExpandedTextButton(
                      text: AppLocalizations.start,
                      callback: () {
                        var activeTimerWatcher = ref.watch(activeTimerProvider);
                        activeTimerWatcher.setTimer(timer);

                        Navigator.of(context).pushNamed(TimerScreen.id);
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIntervals(BuildContext context) {
    List<Widget> result = [];

    for (var i = 0; i < timer.intervals.length; i++) {
      if (i < 6) {
        var item = timer.intervals[i];

        result.add(Text(item.key + ': ' + item.value.toString() + 's',
            style: Theme.of(context).textTheme.headline6));
      }
    }

    return result;
  }
}
