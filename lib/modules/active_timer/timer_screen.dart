import 'package:adaptive_dialog/adaptive_dialog.dart';
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
import 'package:wakelock/wakelock.dart';

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
  ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  ValueNotifier<bool> _hasStarted = ValueNotifier<bool>(false);

  ValueNotifier<bool> _timerRunning = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();

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
        log.info('close');

        return true;
      },
      child: Container(
        color: Theme.of(context).canvasColor,
        child: SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            appBar: CustomAppBar.buildWithAction(
                context, _activeTimerInstance!.timer.name, [
              IconButton(
                  icon: Icon(
                    Icons.close_outlined,
                    size: 30,
                  ),
                  color: Theme.of(context).errorColor,
                  onPressed: () async {
                    if(_hasStarted.value) {
                      _timerRunning.value = false;

                      final result = await showOkCancelAlertDialog(
                        context: context,
                        okLabel: AppLocalizations.close,
                        cancelLabel: AppLocalizations.cancel,
                        title: AppLocalizations.endActivityTitle,
                        message: AppLocalizations.endActivityMessage,
                        defaultType: OkCancelAlertDefaultType.cancel,
                        isDestructiveAction: true,
                      );

                      if (result == OkCancelResult.ok) {
                        AudioHandler.stopAudioFile();
                        _activeTimerInstance!.clear();
                        Navigator.of(context).pop();
                      } else {
                        _timerRunning.value = true;
                      }
                    } else {
                      AudioHandler.stopAudioFile();
                      _activeTimerInstance!.clear();
                      Navigator.of(context).pop();
                    }

                  })
            ]),
            body: Container(
              color: Theme.of(context).canvasColor,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned(top: 0, left: 0, right: 0, child: _buildHeader()),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: _titleName,
                            builder: (context, dynamic value, child) {
                              return Text(
                                '${_titleName.value}',
                                style: Theme.of(context).textTheme.headline4,
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
                                    if (!_hasStarted.value) {
                                      _startTimer();
                                      _hasStarted.value = true;
                                    } else {
                                      _timerRunning.value =
                                          !_timerRunning.value;
                                    }
                                  },
                                  child: CircularPercentIndicator(
                                    radius: 140.0,
                                    backgroundWidth: 10,
                                    animateFromLastPercent: true,
                                    restartAnimation: true,
                                    lineWidth: 20.0,
                                    animation: _hasStarted.value ? true : false,
                                    animationDuration: 1,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    percent: progress >= 0 ? progress : 0,
                                    center: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _hasStarted.value
                                            ? Text(
                                                '${_timeInSec.value}',
                                                // _timeInSec.value ==
                                                //             _currentTargetTime
                                                //                 .value &&
                                                //         !_isLoading.value
                                                //     ? _titleName.value
                                                //     : '${_timeInSec.value}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                              )
                                            : SizedBox(),
                                        Text(
                                          _timerRunning.value
                                              ? AppLocalizations.tapToPause
                                              : _isLoading.value
                                                  ? ''
                                                  : AppLocalizations.tapToStart,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                    progressColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                );
                              })
                        ],
                      )),
                  Positioned(
                    child: _buildProgressStatWidget(),
                    bottom: 0,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
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
          _currentSet.value = setIndex;

          for (int repIndex = 1;
              repIndex <= _activeTimerInstance!.timer.reps;
              repIndex++) {
            if (!this.mounted) return;

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

              await _runTimer(_timeInSec.value);
            }
          }

          if (!this.mounted) return;

          if (_activeTimerInstance!.timer.rest != 0 &&
              _activeTimerInstance!.timer.type == TimerType.reps) {
            _timeInSec.value = _activeTimerInstance!.timer.rest;
            _currentTargetTime.value = _activeTimerInstance!.timer.rest;
            _titleName.value = AppLocalizations.rest;
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

    return Container(
      height: 100,
      child: Row(
        children: children,
      ),
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
                  lineHeight: 13,
                  barRadius: Radius.circular(10),
                  percent: _progress.value <= 1 ? _progress.value : 1,
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
    var timerManagerWatcher = ref.watch(timersManagerProvider);
    timerManagerWatcher.saveActivitiesToHive(_activeTimerInstance!.timer);

    Navigator.pushNamed(context, TimerEndScreen.id);
  }
}
