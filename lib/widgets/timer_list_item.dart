import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:focus/widgets/timer_list_item_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/timer_model.dart';
import '../providers/providers.dart';
import '../screens/timer_details_bottom_sheet.dart';
import '../screens/timer_details_popup.dart';
import '../screens/timer_screen.dart';
import '../utilities/localizations.dart';
import '../utilities/utils.dart';
import 'expanded_test_button.dart';

class TimerListItem extends ConsumerWidget {
  final TimerModel timer;

  TimerListItem(this.timer);
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // return ClipRRect(
    //   borderRadius: BorderRadius.all(Radius.circular(10)),
    //   child: GestureDetector(
    //     onTap: () {
    //
    //       if(timer.type == TimerType.reps){
    //         showDialog(
    //             context: context,
    //             builder: (BuildContext context) => TimerDetailsPopup(timer: timer));
    //       } else {
    //         showModalBottomSheet<void>(
    //           isScrollControlled: true,
    //           context: context,
    //           builder: (BuildContext context) {
    //             return Padding(
    //                 padding: MediaQuery.of(context).viewInsets,
    //                 child: TimerDetailsBottomSheet(timer: timer));
    //           },
    //         );
    //       }
    //     },
    //     child: Container(
    //       color: Theme.of(context).colorScheme.secondary,
    //       height: 65,
    //       padding: EdgeInsets.all(10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               timer.name,
    //               style: Theme.of(context).textTheme.headline6,
    //             ),
    //             Icon(
    //               Icons.arrow_forward_ios,
    //               size: 30,
    //               color: Theme.of(context).primaryColor,
    //             ),
    //           ],
    //         ),
    //     ),
    //   ),
    // );

    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 4,
            onPressed: (context) => ref.read(timersManagerProvider).deleteTimerFromHive(timer),
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
                TimerListItemTile(
                  icon: FontAwesomeIcons.puzzlePiece,
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
          ],
        ),
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

  Widget _buildTimerType(BuildContext context) {
    if (timer.type == TimerType.reps) {
      return TimerListItemTile(
          icon: FontAwesomeIcons.dumbbell,
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
          icon: FontAwesomeIcons.clock,
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
          icon: FontAwesomeIcons.pause,
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

    if(timer.type == TimerType.time && timer.intervals.length > 2){
      objectWidth = 2;
    }

    return StaggeredGridTile.count(
      crossAxisCellCount: objectWidth,
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
}
