import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:focus/modules/timers_list/timer_icon_text_row.dart';
import 'package:focus/modules/timers_list/timer_info_tile.dart';
import 'package:focus/modules/timers_list/timer_info_tile_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/timer_model.dart';
import '../../providers/providers.dart';
import '../active_timer/timer_screen.dart';
import '../../utilities/localizations.dart';
import '../../utilities/utils.dart';
import '../create_timer/edit_timer_screen.dart';

class ExpandableTimerListItem extends ConsumerWidget {
  final TimerModel timer;

  ExpandableTimerListItem(this.timer);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 4,
            onPressed: (context) =>
                ref.read(timersManagerProvider).deleteTimerFromHive(timer),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            icon: Icons.delete,
          ),
          SlidableAction(
            flex: 4,
            onPressed: (context) {
              var activeTimerWatcher = ref.watch(activeTimerProvider);
              activeTimerWatcher.setTimer(timer);

              Navigator.pushNamed(context, EditTimerScreen.id);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.edit,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(10),
          onExpansionChanged: (bool isExpanded) {
            debugPrint('Timer ' + timer.type.toString());
          },
          collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          collapsedIconColor: Theme.of(context).colorScheme.primary,
          iconColor: Theme.of(context).colorScheme.primary,
          title: Container(
            child: Text(
              timer.name,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
            ),
          ),
          children: <Widget>[
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _timerInfo(context, ref),
                _totalTime(context),
                _startButton(context, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timerInfo(BuildContext context, WidgetRef ref) {
    return TimerInfoTile(
        header: TimerInfoTileHeader(
          title: AppLocalizations.timerInfo,
          color: TimerTileStyleConfig.light(context).textColor,
          icon: FontAwesomeIcons.penToSquare,
          onTap: () {
            var activeTimerWatcher = ref.watch(activeTimerProvider);
            activeTimerWatcher.setTimer(timer);
            Navigator.pushNamed(context, EditTimerScreen.id);
          },
        ),
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildTimerType(context),
              SizedBox(height: 2),
              _buildRest(context),
              SizedBox(height: 2),
              _buildIntervals(context)
            ],
          ),
        ),
        style: TimerTileStyleConfig.light(context));
  }

  Widget _buildIntervals(BuildContext context) {
    var intervals = '';

    for (var i = 0; i < timer.intervals.length; i++) {
      var item = timer.intervals[i];

      String suffix = i == timer.intervals.length - 1 ? '' : '-';

      intervals += item.value.toString() + suffix;
    }

    return TimerIconTextRow(intervals, FontAwesomeIcons.hourglassStart
    );
  }

  Widget _buildTimerType(BuildContext context) {
    if (timer.type == TimerType.reps) {
      return TimerIconTextRow(
          timer.sets.toString() + 'X' + timer.reps.toString(),
          FontAwesomeIcons.dumbbell);
    } else {
      return TimerIconTextRow(
          Utils.formatTime(timer.time), FontAwesomeIcons.clock);
    }
  }

  Widget _buildRest(BuildContext context) {
    if (timer.rest != 0 && timer.type == TimerType.reps) {
      return TimerIconTextRow(
          Utils.formatTime(timer.rest), FontAwesomeIcons.pause);
    } else {
      return TimerIconTextRow(
          '-', FontAwesomeIcons.pause);
    }
  }

  Widget _startButton(BuildContext context, WidgetRef ref) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: GestureDetector(
        onTap: () {
          var activeTimerWatcher = ref.watch(activeTimerProvider);
          activeTimerWatcher.setTimer(timer);

          Navigator.of(context).pushNamed(TimerScreen.id);
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Icon(FontAwesomeIcons.circlePlay, size: 60, color: Theme.of(context).primaryColor,),
          ),
        ),
      ),
    );
  }

  Widget _totalTime(BuildContext context) {
    return TimerInfoTile(
        header: TimerInfoTileHeader(
          title: AppLocalizations.totalTime,
          color: TimerTileStyleConfig.dark(context).textColor,
          icon: FontAwesomeIcons.flagCheckered,
          onTap: () => debugPrint('total time'),
        ),
        crossAxisCellCount: 2,
        mainAxisCellCount: 1,
        child: Text(
          Utils.formatTime(timer.getTotalSeconds()),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        style: TimerTileStyleConfig.dark(context));
  }
}
