import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/timer_model.dart';
import '../../providers/providers.dart';
import '../../utilities/localizations.dart';
import '../../utilities/utils.dart';
import '../active_timer/timer_screen.dart';
import '../create_timer/edit_timer_screen.dart';

// ignore: camel_case_types
enum timerPanel { intervals, time }

class GridTimerItem extends ConsumerStatefulWidget {
  final TimerModel timer;

  GridTimerItem(this.timer);
  @override
  GridTimerItemState createState() => GridTimerItemState();
}

class GridTimerItemState extends ConsumerState<GridTimerItem>
    with SingleTickerProviderStateMixin {
  List<timerPanel> _panels = [
    timerPanel.intervals,
    timerPanel.time,
  ];

  int _currentIndex = 0;
  bool _inEditMode = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.0), weight: 1),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        int swipeDirection = details.velocity.pixelsPerSecond.dx.sign.toInt();
        setState(() {
          if (_inEditMode) _inEditMode = false;
          _currentIndex = (_currentIndex + swipeDirection) % _panels.length;
        });
      },
      onTap: () {
        if (_inEditMode) {
          setState(() {
            _inEditMode = false;
          });
        } else {
          var activeTimerWatcher = ref.watch(activeTimerProvider);
          activeTimerWatcher.setTimer(widget.timer);

          Navigator.pushNamed(context, TimerScreen.id);
        }
      },
      onLongPressStart: (details) {
        if (!_inEditMode) {
          _controller.reset();
          _controller.forward();
        }

        setState(() {
          _inEditMode = !_inEditMode;
        });
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: child,
          );
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, top: 5, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                widget.timer.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          if (_currentIndex == 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  children: [
                                    _buildInfo(
                                        context,
                                        Utils.formatTime(
                                            widget.timer.getTotalSeconds()),
                                        FontAwesomeIcons.clock),
                                  ],
                                ),
                              ],
                            ),
                          if (_currentIndex == 1)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Intervals',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  children: [_buildIntervals(context)],
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_inEditMode)
              Positioned(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        var activeTimerWatcher = ref.watch(activeTimerProvider);
                        activeTimerWatcher.setTimer(widget.timer);

                        showModalBottomSheet<void>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return EditTimerScreen();
                          },
                        );
                      },
                      icon: Icon(
                        FontAwesomeIcons.gear,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      )),
                  top: -10,
                  right: -10),
            if (_inEditMode)
              Positioned(
                  child: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        final result = await showOkCancelAlertDialog(
                          context: context,
                          okLabel: AppLocalizations.delete,
                          cancelLabel: AppLocalizations.cancel,
                          title: AppLocalizations.deleteTimer,
                          message: AppLocalizations.deleteTimerMessage,
                          defaultType: OkCancelAlertDefaultType.cancel,
                          isDestructiveAction: true,
                        );

                        if (result == OkCancelResult.ok) {
                          ref
                              .read(timersManagerProvider)
                              .deleteTimerFromHive(widget.timer);
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        color: Theme.of(context).colorScheme.error,
                        size: 18,
                      )),
                  bottom: -10,
                  right: -10)
          ],
        ),
      ),
    );
  }

  Widget _buildIntervals(BuildContext context) {
    var intervals = '';

    for (var i = 0; i < widget.timer.intervals.length; i++) {
      var item = widget.timer.intervals[i];

      String suffix = i == widget.timer.intervals.length - 1 ? '' : '-';

      intervals += item.value.toString() + suffix;
    }

    return _buildInfo(context, intervals, FontAwesomeIcons.hourglassStart);
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
            child: Center(
              child: FaIcon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 12,
              ),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
