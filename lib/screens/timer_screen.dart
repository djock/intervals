import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:focus/utilities/audio_handler.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/widgets/round_button.dart';

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

  ValueNotifier<String> _titleName = ValueNotifier<String>(AppLocalizations.getReady);
  ValueNotifier<int> _timeInSec = ValueNotifier<int>(5);
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
    _timeInSec.dispose();
    _progress.dispose();
    _resumeFlag.dispose();
    _currentRep.dispose();
    _currentSet.dispose();
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
        appBar: AppBar(
          // title: Text('Tempo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ValueListenableBuilder(
                valueListenable: _titleName,
                builder: (context, dynamic value, child) {
                  return Text(
                    '${_titleName.value}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 3,
                      color: Colors.black45,
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _timeInSec,
                builder: (context, dynamic value, child) {
                  return Text(
                    '${_timeInSec.value}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      letterSpacing: 3,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _progress,
                    builder: (context, dynamic value, child) {
                      return Text(AppLocalizations.currentSet.replaceAll('{AMOUNT}', '${_currentSet.value}')
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _progress,
                    builder: (context, dynamic value, child) {
                      return Text(AppLocalizations.currentRep.replaceAll('{AMOUNT}', '${_currentRep.value}'
                      ));
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _progress,
                    builder: (context, dynamic value, child) {
                      return Text(AppLocalizations.currentProgress.replaceAll('{AMOUNT}', '${_progress.value}'
                      ));
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _resumeFlag,
                    builder: (context, dynamic value, child) {
                      return RoundButton(
                        color: buttonColor,
                        child: Icon(
                          _resumeFlag.value ? Icons.pause : Icons.play_arrow,
                          color: roundButtonIconColor,
                          size: roundButtonIconSize,
                        ),
                        onPressed: () {
                          _resumeFlag.value = !_resumeFlag.value;
                        },
                      );
                    },
                  ),
                ],
              )
            ],
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
      if (this.mounted && _timeInSec.value != 0) _progress.value += 100 / _totalTime!;

      if(this.mounted){
        AudioHandler.playTick();
      }

      await Future.delayed(Duration(seconds: 1));
      if(this.mounted) {
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
            tempoIndex < _timerSettings.temposList.length;
            tempoIndex++) {
          AudioHandler.playSwitch();

          _titleName.value = _timerSettings.temposList.elementAt(tempoIndex).key;
          var currentTempo = _timerSettings.temposList.elementAt(tempoIndex).value;
          _timeInSec.value = currentTempo;

          await _runTimer(_timeInSec.value);
        }
      }

      if(_timerSettings.rest != 0) {
        _timeInSec.value = _timerSettings.rest;
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
}
