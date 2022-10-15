import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/handlers/timer_handler.dart';
import 'package:focus/modules/active_timer/timer_end_screen.dart';
import 'package:focus/modules/active_timer/timer_stat_widget.dart';
import 'package:focus/providers/providers.dart';
import 'package:focus/utilities/audio_handler.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../models/timer_type_enum.dart';
import '../../utilities/utils.dart';
import '../../widgets/custom_app_bar.dart';

class TimerScreen extends ConsumerStatefulWidget {
  static const String id = 'TimerScreen';

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends ConsumerState<TimerScreen> {
  // late AudioPlayer audioPlayer;

  ActiveTimer? _activeTimerInstance;
  int? _timerTotalSeconds;

  int _timePassedSoFar = 0;

  ValueNotifier<String> _titleName =
      ValueNotifier<String>(AppLocalizations.getReady);
  ValueNotifier<String> _nextTitle =
      ValueNotifier<String>(AppLocalizations.getReady);
  ValueNotifier<int> _timeInSec = ValueNotifier<int>(5);
  ValueNotifier<int> _currentTargetTime = ValueNotifier<int>(5);
  ValueNotifier<double> _progress = ValueNotifier<double>(0);
  ValueNotifier<int> _currentRep = ValueNotifier<int>(1);
  ValueNotifier<int> _currentSet = ValueNotifier<int>(1);
  ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);
  ValueNotifier<bool> _hasStarted = ValueNotifier<bool>(false);

  ValueNotifier<bool> _timerRunning = ValueNotifier<bool>(false);

  @override
  void dispose() {
    super.dispose();
    _timeInSec.value = 0;
    _titleName.dispose();
    _nextTitle.dispose();
    _timeInSec.dispose();
    _progress.dispose();
    _currentRep.dispose();
    _currentSet.dispose();
    _currentTargetTime.dispose();
    _hasStarted.dispose();
    _isLoading.dispose();
    _timerRunning.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _activeTimerInstance = ref.watch(activeTimerProvider);
    _timerTotalSeconds = _activeTimerInstance!.timer.getTotalSeconds();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar.buildWithAction(
            context, _activeTimerInstance!.timer.name, [
          IconButton(
              icon: Icon(
                Icons.close_outlined,
                size: 30,
              ),
              color: Theme.of(context).errorColor,
              onPressed: () {
                _activeTimerInstance!.clear();
                Navigator.of(context).pop();
              })
        ]),
        body: Container(
          color: Theme.of(context).canvasColor,
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _titleName,
                        builder: (context, dynamic value, child) {
                          return Text(
                            '${_titleName.value}',
                            style: Theme.of(context).textTheme.headline5,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _timeInSec,
                          builder: (context, dynamic value, child) {
                            var progress = (_timeInSec.value - 1) *
                                100 /
                                (_currentTargetTime.value - 1) /
                                100;

                            return GestureDetector(
                              onTap: () {
                                log.info('tap');

                                if (!_hasStarted.value) {
                                  _startTimer();
                                  _hasStarted.value = true;
                                } else {
                                  _timerRunning.value = !_timerRunning.value;
                                }
                              },
                              child: CircularPercentIndicator(
                                radius: 125.0,
                                backgroundWidth: 15,
                                animateFromLastPercent: true,
                                restartAnimation: true,
                                lineWidth: 28.0,
                                animation: _hasStarted.value ? true : false,
                                animationDuration: 1000,
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                percent: progress >= 0 ? progress : 0,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _hasStarted.value
                                        ? Text(
                                            _timeInSec.value ==
                                                        _currentTargetTime
                                                            .value &&
                                                    !_isLoading.value
                                                ? _titleName.value
                                                : '${_timeInSec.value}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2,
                                          )
                                        : SizedBox(),
                                    Text(
                                      _timerRunning.value
                                          ? AppLocalizations.tapToPause
                                          : AppLocalizations.tapToStart,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                                progressColor: Theme.of(context).primaryColor,
                              ),
                            );
                          })
                    ],
                  ),
                ),
                _buildProgressStatWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _runProgressTimer() async {
    for (var i = 1; i <= _timerTotalSeconds!; i++) {
      _timePassedSoFar += 1;

      if (this.mounted) {
        _progress.value = _timePassedSoFar * 100 / _timerTotalSeconds! / 100;
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> _runTimer(int? time) async {
    if (this.mounted) {
      while (_timeInSec.value > 0) {
        while (!_timerRunning.value) {
          await Future.delayed(Duration(milliseconds: 10));
        }

        if (this.mounted) {
          if (_timeInSec.value == 1 ||
              _timeInSec.value == 2 ||
              _timeInSec.value == 3) {
            AudioHandler.playTick();
          }
        }

        await Future.delayed(Duration(seconds: 1));
        if (this.mounted) {
          _timeInSec.value--;
        }
      }
    }
  }

  void _startTimer() async {
    _currentTargetTime.value = 10;

    for (var i = 10; i > 0; i--) {
      if (!this.mounted) return;
      _isLoading.value = true;
      _timeInSec.value = i;

      if (_timeInSec.value == 1 ||
          _timeInSec.value == 2 ||
          _timeInSec.value == 3) {
        AudioHandler.playTick();
      }

      await Future.delayed(Duration(seconds: 1));
    }

    AudioHandler.playSwitch();
    _runProgressTimer();

    _isLoading.value = false;
    _timerRunning.value = true;

    if (_activeTimerInstance!.timer.type == TimerType.reps) {
      if (this.mounted) {
        for (int setIndex = 1;
            setIndex <= _activeTimerInstance!.timer.sets;
            setIndex++) {
          if (!this.mounted) return;
          log.info(':::: set ' + setIndex.toString());
          _currentSet.value = setIndex;

          for (int repIndex = 1;
              repIndex <= _activeTimerInstance!.timer.reps;
              repIndex++) {
            if (!this.mounted) return;

            log.info(':::: rep ' + repIndex.toString());

            _currentRep.value = repIndex;

            for (int tempoIndex = 0;
                tempoIndex < _activeTimerInstance!.timer.intervals.length;
                tempoIndex++) {
              AudioHandler.playSwitch();

              if (!this.mounted) return;
              _titleName.value = _activeTimerInstance!.timer.intervals
                  .elementAt(tempoIndex)
                  .key;

              if (!this.mounted) return;
              var currentTempo = _activeTimerInstance!.timer.intervals
                  .elementAt(tempoIndex)
                  .value;

              if (!this.mounted) return;
              {
                _timeInSec.value = currentTempo;
              }

              if (!this.mounted) return;
              _currentTargetTime.value = currentTempo;

              log.info('here');
              await _runTimer(_timeInSec.value);
            }
          }

          if (!this.mounted) return;

          log.info('here ' + _activeTimerInstance!.timer.rest.toString());

          if (_activeTimerInstance!.timer.rest != 0) {
            _timeInSec.value = _activeTimerInstance!.timer.rest;
            _currentTargetTime.value = _activeTimerInstance!.timer.rest;
            _titleName.value = AppLocalizations.rest;
            log.info('here');
            await _runTimer(_timeInSec.value);
          }
        }
        _timeInSec.value = 0;
        // if (isVoice!) {
        //   await audioPlayer.setAsset('assets/audio/$voice/finish-$voice.mp3');
        //   audioPlayer.play();
        //   // AudioCache finishPlayer = AudioCache(prefix: 'assets/audio/$voice/');
        //   // finishPlayer.play('finish-$voice.mp3');
        //   // audioPlayer.clearCache();
        //   isVoice = false;
        // }
        endWorkout(context);
      }
    } else {
      if (this.mounted) {
        while (_timePassedSoFar < _activeTimerInstance!.timer.time) {
          for (int i = 0;
              i < _activeTimerInstance!.timer.intervals.length;
              i++) {
            AudioHandler.playSwitch();

            if (!this.mounted) return;
            _titleName.value =
                _activeTimerInstance!.timer.intervals.elementAt(i).key;

            if (!this.mounted) return;
            var currentTempo =
                _activeTimerInstance!.timer.intervals.elementAt(i).value;

            if (!this.mounted) return;
            {
              _timeInSec.value = currentTempo;
            }

            if (!this.mounted) return;
            _currentTargetTime.value = currentTempo;

            log.info('here');
            await _runTimer(_timeInSec.value);
          }
        }

        endWorkout(context);
      }
    }
  }

  Widget _buildInfoText(ValueNotifier valueNotifier, int max, String title) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, dynamic value, child) {
        return TimerStatWidget(
          value: valueNotifier.value.toString() + "/" + max.toString(),
          title: title,
        );
      },
    );
  }

  Widget _buildHeader() {
    List<Widget> children = [];

    if (_activeTimerInstance!.timer.type == TimerType.reps) {
      children.add(_buildInfoText(_currentSet, _activeTimerInstance!.timer.sets,
          AppLocalizations.currentSet));
      children.add(_buildInfoText(_currentRep, _activeTimerInstance!.timer.reps,
          AppLocalizations.currentRep));
    } else {
      children.add(TimerStatWidget(
        value: Utils.formatTime(_activeTimerInstance!.timer.time),
        title: AppLocalizations.totalTime,
      ));
    }

    return Row(
      children: children,
    );
  }

  Widget _buildProgressStatWidget() {
    return ValueListenableBuilder(
      valueListenable: _progress,
      builder: (context, dynamic value, child) {
        return Container(
            height: 85,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    AppLocalizations.progress,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                SizedBox(
                  height: 5,
                ),
                new LinearPercentIndicator(
                  animateFromLastPercent: true,
                  animation: true,
                  animationDuration: 1000,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  progressColor: Theme.of(context).primaryColor,
                  width: 350,
                  lineHeight: 15,
                  barRadius: Radius.circular(10),
                  percent: _progress.value <= 1 ? _progress.value : 1,
                  // center: Container(height: 20, width: 20, color: Colors.red,)
                  // widgetIndicator: Container(
                  //   height: 20,
                  //   width: 20,
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).colorScheme.primary,
                  //       borderRadius: BorderRadius.all(Radius.circular(100))),
                  //   child: Center(
                  //     child: Container(
                  //       height: 15,
                  //       width: 15,
                  //       decoration: BoxDecoration(
                  //           color: Theme.of(context).canvasColor,
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(100))),
                  //     ),
                  //   ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        '${(_progress.value * 100).toInt()}%',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      Text(
                        ' / ' + Utils.formatTime(_timerTotalSeconds!),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).primaryColor)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  void endWorkout(BuildContext context) {
    Navigator.pushNamed(context, TimerEndScreen.id);
  }
}
