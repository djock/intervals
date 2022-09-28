import 'package:flutter/material.dart';
import 'package:focus/utilities/audio_handler.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/widgets/expanded_test_button.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/timer_stat_widget.dart';

class TimerScreen extends StatefulWidget {
  static const String id = 'TimerScreen';

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  // late AudioPlayer audioPlayer;

  var _timerSettings = activeTimerSettings;

  bool _firstInstance = true;
  int? _totalTime;

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

  @override
  void initState() {
    super.initState();
    _totalTime = _timerSettings.getTotalTime();
  }

  @override
  void dispose() {
    super.dispose();
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
              icon: Icon(Icons.close_outlined),
              color: Theme.of(context).colorScheme.onPrimary,
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
                    _buildSetsStatWidget(),
                    _buildRepsStatWidget(),
                    _buildProgressStatWidget(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: _titleName,
                  builder: (context, dynamic value, child) {
                    return Text(
                      '${_titleName.value}',
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                width: 200,
                                child: new CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  strokeWidth: 8,
                                  value: 1,
                                ),
                              ),
                            ),
                            Center(
                              child: ValueListenableBuilder(
                                valueListenable: _timeInSec,
                                builder: (context, dynamic value, child) {
                                  return Container(
                                    height: 200,
                                    width: 200,
                                    child: new CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      strokeWidth: 10,
                                      value: (_timeInSec.value *
                                              100 /
                                              _currentTargetTime.value) /
                                          100,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: ValueListenableBuilder(
                                valueListenable: _timeInSec,
                                builder: (context, dynamic value, child) {
                                  return Text(
                                    '${_timeInSec.value}',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _resumeFlag,
                  builder: (context, dynamic value, child) {
                    return ExpandedTextButton(
                        text: _resumeFlag.value
                            ? AppLocalizations.pauseTimerButton
                            : AppLocalizations.resumeTimerButton,
                        callback: () {
                          _resumeFlag.value = !_resumeFlag.value;
                        });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _runTimer(int? time) async {
    while (_timeInSec.value >= 0) {
      while (!_resumeFlag.value) {
        await Future.delayed(Duration(milliseconds: 10));
      }
      if (this.mounted && _timeInSec.value != 0)
        _progress.value += 100 / _totalTime!;

      if (this.mounted) {
        AudioHandler.playTick();
      }

      await Future.delayed(Duration(seconds: 1));
      if (this.mounted) {
        _timeInSec.value--;
      }
    }
  }

  void _startTimer() async {
    AudioHandler.playSwitch();
    _timeInSec.value = 5;
    await Future.delayed(Duration(seconds: 1));
    AudioHandler.playTick();
    _timeInSec.value = 4;
    await Future.delayed(Duration(seconds: 1));
    AudioHandler.playTick();
    _timeInSec.value = 3;
    await Future.delayed(Duration(seconds: 1));
    AudioHandler.playTick();
    _timeInSec.value = 2;
    await Future.delayed(Duration(seconds: 1));
    AudioHandler.playTick();
    _timeInSec.value = 1;
    await Future.delayed(Duration(seconds: 1));
    AudioHandler.playSwitch();
    for (int setIndex = 1; setIndex <= _timerSettings.sets; setIndex++) {
      _currentSet.value = setIndex;

      for (int repIndex = 1; repIndex <= _timerSettings.reps; repIndex++) {
        _currentRep.value = repIndex;

        for (int tempoIndex = 0;
            tempoIndex < _timerSettings.intervals.length;
            tempoIndex++) {
          AudioHandler.playSwitch();

          _titleName.value =
              _timerSettings.intervals.elementAt(tempoIndex).key;
          var currentTempo =
              _timerSettings.intervals.elementAt(tempoIndex).value;
          _timeInSec.value = currentTempo;
          _currentTargetTime.value = currentTempo;

          await _runTimer(_timeInSec.value);
        }
      }

      if (_timerSettings.rest != 0) {
        _timeInSec.value = _timerSettings.rest;
        _currentTargetTime.value = _timerSettings.rest;
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
    Navigator.pop(context);
  }

  Widget _buildSetsStatWidget() {
    return ValueListenableBuilder(
      valueListenable: _currentSet,
      builder: (context, dynamic value, child) {
        return TimerStatWidget(
          value: _currentSet.value.toString() + "/" + _timerSettings.sets.toString(),
          title: AppLocalizations.currentSet,
        );
      },
    );
  }

  Widget _buildRepsStatWidget() {
    return ValueListenableBuilder(
      valueListenable: _currentRep,
      builder: (context, dynamic value, child) {
        return TimerStatWidget(
          value: _currentRep.value.toString() + "/" + _timerSettings.reps.toString(),
          title: AppLocalizations.currentRep,
        );
      },
    );
  }

  Widget _buildProgressStatWidget() {
    return ValueListenableBuilder(
      valueListenable: _progress,
      builder: (context, dynamic value, child) {
        return TimerStatWidget(
          value: _progress.value.toStringAsFixed(1) + '%',
          title: AppLocalizations.currentProgress,
        );
      },
    );
  }
}
