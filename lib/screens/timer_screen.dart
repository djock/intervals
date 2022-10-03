import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/handlers/timer_handler.dart';
import 'package:focus/providers/providers.dart';
import 'package:focus/utilities/audio_handler.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utilities/utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/timer_stat_widget.dart';

class TimerScreen extends ConsumerStatefulWidget {
  static const String id = 'TimerScreen';

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends ConsumerState<TimerScreen> {
  // late AudioPlayer audioPlayer;

  ActiveTimer? _timerInstance;
  int? _totalTime;

  int _timePassedSoFar = 0;

  ValueNotifier<String> _titleName =
      ValueNotifier<String>(AppLocalizations.getReady);
  ValueNotifier<String> _nextTitle =
      ValueNotifier<String>(AppLocalizations.getReady);
  ValueNotifier<int> _timeInSec = ValueNotifier<int>(5);
  ValueNotifier<int> _currentTargetTime = ValueNotifier<int>(5);
  ValueNotifier<double> _progress = ValueNotifier<double>(0);
  ValueNotifier<bool> _resumeFlag = ValueNotifier<bool>(true);
  ValueNotifier<int> _currentRep = ValueNotifier<int>(1);
  ValueNotifier<int> _currentSet = ValueNotifier<int>(1);
  ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();
    _timeInSec.value = 0;
    _titleName.dispose();
    _nextTitle.dispose();
    _timeInSec.dispose();
    _progress.dispose();
    _resumeFlag.dispose();
    _currentRep.dispose();
    _currentSet.dispose();
    _currentTargetTime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _timerInstance = ref.watch(activeTimerProvider);

    _totalTime = _timerInstance!.getTotalSeconds();

    // if(_firstInstance) {
    _startTimer();
    // _firstInstance = false;
    // }

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar.buildWithAction(context, '', [
          IconButton(
              icon: Icon(
                Icons.close_outlined,
                size: 30,
              ),
              color: Theme.of(context).errorColor,
              onPressed: () {
                Navigator.of(context).pop();
              })
        ]),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildInfoText(_currentSet, _timerInstance!.timer.sets,
                        AppLocalizations.currentSet),
                    _buildInfoText(_currentRep, _timerInstance!.timer.reps,
                        AppLocalizations.currentRep),
                  ],
                ),
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

                            return CircularPercentIndicator(
                              radius: 125.0,
                              backgroundWidth: 15,
                              animateFromLastPercent: true,
                              restartAnimation: true,
                              lineWidth: 28.0,
                              animation: true,
                              animationDuration: 1000,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              percent: progress >= 0 ? progress : 0,
                              center: Text(
                                _timeInSec.value == _currentTargetTime.value && !_isLoading.value
                                    ? _titleName.value
                                    : '${_timeInSec.value}',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              progressColor: Theme.of(context).primaryColor,
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
    for (var i = 1; i <= _totalTime!; i++) {
      _timePassedSoFar += 1;

      if (this.mounted) {
        _progress.value = _timePassedSoFar * 100 / _totalTime! / 100;
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> _runTimer(int? time) async {
    if (this.mounted) {
      while (_timeInSec.value > 0) {
        while (!_resumeFlag.value) {
          await Future.delayed(Duration(milliseconds: 10));
        }

        if (this.mounted) {
          if (_timeInSec.value == 0 ||
              _timeInSec.value == 1 ||
              _timeInSec.value == 2) {
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
      await Future.delayed(Duration(seconds: 1));
    }

    AudioHandler.playSwitch();
    _runProgressTimer();

    _isLoading.value = false;

    if (this.mounted) {
      for (int setIndex = 1; setIndex <= _timerInstance!.timer.sets; setIndex++) {
        if (!this.mounted) return;
        log.info(':::: set ' + setIndex.toString());
        _currentSet.value = setIndex;

        for (int repIndex = 1; repIndex <= _timerInstance!.timer.reps; repIndex++) {
          if (!this.mounted) return;

          log.info(':::: rep ' + repIndex.toString());

          _currentRep.value = repIndex;

          for (int tempoIndex = 0;
              tempoIndex < _timerInstance!.timer.intervals.length;
              tempoIndex++) {
            AudioHandler.playSwitch();

            if (!this.mounted) return;
            _titleName.value =
                _timerInstance!.timer.intervals.elementAt(tempoIndex).key;

            if (!this.mounted) return;
            var currentTempo =
                _timerInstance!.timer.intervals.elementAt(tempoIndex).value;

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

        log.info('here ' + _timerInstance!.timer.rest.toString());

        if (_timerInstance!.timer.rest != 0) {
          _timeInSec.value = _timerInstance!.timer.rest;
          _currentTargetTime.value = _timerInstance!.timer.rest;
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
      Navigator.pop(context);
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

  Widget _buildProgressStatWidget() {
    return ValueListenableBuilder(
      valueListenable: _progress,
      builder: (context, dynamic value, child) {
        debugPrint('progress ' + _progress.value.toString());

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
                  percent: _progress.value,
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
                        ' / ' + Utils.formatTime(_totalTime!),
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
}
