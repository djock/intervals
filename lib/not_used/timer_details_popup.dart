import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/screens/pop_scope_screen.dart';
import 'package:focus/screens/timer_screen.dart';

import '../models/timer_model.dart';
import '../models/timer_tile_style.dart';
import '../models/timer_type_enum.dart';
import '../providers/providers.dart';
import '../utilities/localizations.dart';
import '../utilities/utils.dart';
import '../widgets/expanded_test_button.dart';
import 'timer_list_item_tile.dart';

class TimerDetailsPopup extends ConsumerWidget {
  final TimerModel timer;

  TimerDetailsPopup({required this.timer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        height: 300.0,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    TimerListItemTile(
                        icon: Icons.timer,
                        title: AppLocalizations.intervals,
                        crossAxisCellCount: 2,
                        mainAxisCellCount: timer.intervals.length > 2 ? 2 : 1,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: _buildIntervals(context),
                            ),
                          ),
                        ),
                        style: TimerTileStyleConfig.light(context)),
                    _buildTimerType(context),
                    _buildRest(context),
                    _buildStartButton(context, ref),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Column(
          children: [
            SizedBox(
                height: 60,
                child: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  leading: SizedBox(),
                  // leading: IconButton(
                  //     icon: Icon(
                  //       Icons.close_outlined,
                  //       size: 30,
                  //     ),
                  //     color: Theme.of(context).errorColor,
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //     }),
                  centerTitle: true,
                  title: Text(
                    timer.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  actions: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                          icon: Icon(
                            Icons.close_outlined,
                            size: 30,
                          ),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 0.2,
              color: Theme.of(context).colorScheme.tertiary,
            )
          ],
        ));
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

  Widget _buildTimerType(BuildContext context) {
    if (timer.type == TimerType.reps) {
      return TimerListItemTile(
          icon: Icons.timer,
          title: AppLocalizations.setsReps,
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(
            timer.sets.toString() + 'x' + timer.reps.toString(),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          style: TimerTileStyleConfig.dark(context));
    } else {
      return TimerListItemTile(
          icon: Icons.timer,
          title: AppLocalizations.totalTime,
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(
            Utils.formatTime(timer.time),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          style: TimerTileStyleConfig.dark(context));
    }
  }

  Widget _buildRest(BuildContext context) {
    if (timer.rest != 0 && timer.type == TimerType.reps) {
      return TimerListItemTile(
          icon: Icons.timer,
          title: AppLocalizations.rest,
          crossAxisCellCount: 2,
          mainAxisCellCount: 1,
          child: Text(
            Utils.formatTime(timer.rest),
            style: Theme.of(context).textTheme.headline6,
          ),
          style: TimerTileStyleConfig.light(context));
    } else {
      return SizedBox();
    }
  }

  Widget _buildStartButton(BuildContext context, WidgetRef ref) {
    var objectWidth = 4;

    if (timer.type == TimerType.reps) {
      objectWidth = 2; // it has rest timer included
    }

    if (timer.type == TimerType.reps && timer.intervals.length > 2) {
      objectWidth = 4;
    }

    if (timer.type == TimerType.time && timer.intervals.length > 2) {
      objectWidth = 2;
    }

    return StaggeredGridTile.count(
      crossAxisCellCount: objectWidth,
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
    );
  }
}
