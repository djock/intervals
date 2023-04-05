import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';
import 'package:focus/modules/timers_list/timer_info_tile.dart';
import 'package:focus/modules/timers_list/timer_info_tile_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/timer_model.dart';
import '../../providers/providers.dart';
import '../../utilities/localizations.dart';
import '../../utilities/utils.dart';
import 'package:intl/intl.dart';


class ExpandableTimerListItem extends ConsumerWidget {
  final TimerModel timer;

  ExpandableTimerListItem(this.timer);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var now = new DateTime.fromMillisecondsSinceEpoch(timer.date);
    var formatter = new DateFormat('dd MMM yyyy  HH:mm');
    String formattedDate = formatter.format(now);

    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) =>
                ref.read(timersManagerProvider).deleteTimerFromHive(timer),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(10),
          onExpansionChanged: (bool isExpanded) {
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
          subtitle: Text(
            formattedDate,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          children: <Widget>[
            StaggeredGrid.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              children: [
                _timerInfo(context, ref),
                _totalTime(context),
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
          title: AppLocalizations.intervals,
          color: TimerTileStyleConfig.light(context).textColor,
          icon: FontAwesomeIcons.hourglassStart,
          onTap: () {
          },
        ),
        crossAxisCellCount: 2,
        mainAxisCellCount: 1,
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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

    return Text(
      intervals,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Theme.of(context).colorScheme.primary),
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
