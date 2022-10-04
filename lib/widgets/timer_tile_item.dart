import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/timer_type_enum.dart';
import '../providers/providers.dart';
import '../screens/timer_screen.dart';
import '../utilities/utils.dart';

class TimerTileItem extends ConsumerWidget {
  final TimerModel timer;

  TimerTileItem(this.timer);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TimerScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      timer.name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 0.5,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTimerType(context),
                      SizedBox(
                        height: 5,
                      ),
                      _buildIntervals(context),
                    ],
                  )),
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildIconButton(
                        context,
                        FontAwesomeIcons.penToSquare,
                        Theme.of(context).primaryColor,
                        () => {log.info('edit')}),
                    _buildIconButton(context, FontAwesomeIcons.trash,
                        Theme.of(context).colorScheme.error, () {
                      ref
                          .read(timersManagerProvider)
                          .deleteTimerFromHive(timer);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildRow(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 20,
          child: Center(
            child: FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, Color iconColor,
      Function onPressed) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: FaIcon(
        icon,
        color: iconColor,
        size: 18,
      ),
    );
  }
}
