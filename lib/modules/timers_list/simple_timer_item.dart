import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

class SimpleTimerItem extends ConsumerWidget {
  final TimerModel timer;

  SimpleTimerItem(this.timer);
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
      child: GestureDetector(
        onTap: () {
          var activeTimerWatcher = ref.watch(activeTimerProvider);
          activeTimerWatcher.setTimer(timer);

          Navigator.pushNamed(context, TimerScreen.id);
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 0.8,
                ),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timer.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      _buildInfo(context, Utils.formatTime(timer.getTotalSeconds()),
                          FontAwesomeIcons.clock),
                      SizedBox(
                        width: 10,
                      ),
                      _buildIntervals(context)
                    ],
                  )
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 30,
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    var activeTimerWatcher = ref.watch(activeTimerProvider);
                    activeTimerWatcher.setTimer(timer);

                    Navigator.of(context).pushNamed(TimerScreen.id);
                  })
            ],
          ),
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

    return _buildInfo(context, intervals, FontAwesomeIcons.hourglassStart);
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
      return TimerIconTextRow('-', FontAwesomeIcons.pause);
    }
  }

  Widget _buildInfo(BuildContext context, String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Container(
            width: 20,
            child: Center(
              child: FaIcon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
            ),
          ),
          SizedBox(width: 3,),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
