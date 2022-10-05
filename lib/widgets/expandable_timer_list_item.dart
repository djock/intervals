import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:focus/widgets/timer_info_tile.dart';
import 'package:focus/not_used/timer_list_item_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/timer_model.dart';
import '../providers/providers.dart';
import '../screens/timer_screen.dart';
import '../utilities/localizations.dart';
import '../utilities/utils.dart';
import 'expanded_test_button.dart';

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
            onPressed: (context) => debugPrint('edit'),
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
          title: Text(
            timer.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          children: <Widget>[
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _timerInfo(context),
                _totalTime(context),
                _startButton(context, ref),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timerInfo(BuildContext context) {
    return TimerInfoTile(
      header: SizedBox(),
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_buildTimerType(context), _buildRest(context), _buildIntervals(context)],
            ),
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

    return _buildRow(context, intervals, FontAwesomeIcons.solidHourglass);
  }

  Widget _buildTimerType(BuildContext context) {
    if (timer.type == TimerType.reps) {
      return _buildRow(
          context,
          timer.sets.toString() + 'x' + timer.reps.toString(),
          FontAwesomeIcons.dumbbell);
    } else {
      return _buildRow(
          context, Utils.formatTime(timer.time), FontAwesomeIcons.clock);
    }
  }

  Widget _buildRest(BuildContext context) {
    if (timer.rest != 0 && timer.type == TimerType.reps) {
      return _buildRow(
          context,
          Utils.formatTime(timer.rest),
          FontAwesomeIcons.pause);
    } else {
      return SizedBox();
    }
  }

  Widget _startButton(BuildContext context, WidgetRef ref) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ExpandedTextButton(
                text: AppLocalizations.start,
                callback: () {
                  var activeTimerWatcher = ref.watch(activeTimerProvider);
                  activeTimerWatcher.setTimer(timer);

                  Navigator.of(context).pushNamed(TimerScreen.id);
                }),
          ),
        ],
      ),
    );
  }

  Widget _totalTime(BuildContext context) {
    var style = TimerTileStyleConfig.dark(context);

    return TimerInfoTile(
      header:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.totalTime,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: style.textColor),
          ),
          FaIcon(
            FontAwesomeIcons.clock,
            color: style.textColor,
            size: 12,
          )
        ],
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

  Widget _buildRow(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 20,
          child: Center(
            child: FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
