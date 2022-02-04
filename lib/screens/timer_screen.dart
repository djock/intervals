import 'package:flutter/material.dart';
import 'package:focus/models/timer_settings.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/add_button.dart';
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

  ValueNotifier<String> _titleName = ValueNotifier<String>('Get Ready!');
  ValueNotifier<int> _timeInSec = ValueNotifier<int>(5);
  // ValueNotifier<double> _tickTime = ValueNotifier<double>(0);
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
          title: Text('Tempo'),
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
                      return Text(
                        'Set: ${_currentSet.value}',
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _progress,
                    builder: (context, dynamic value, child) {
                      return Text(
                        'Rep: ${_currentRep.value}',
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: _progress,
                    builder: (context, dynamic value, child) {
                      return Text(
                        'Progress: ${_progress.value.toStringAsFixed(0)}%',
                      );
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
      if (_timeInSec.value != 0) _progress.value += 100 / _totalTime!;
      // if (timeInSec.value <= 5 && timeInSec.value > 0 && isVoice!) {
      //   await audioPlayer
      //       .setAsset('assets/audio/$voice/${timeInSec.value}-$voice.mp3');
      //   audioPlayer.play();
      //   // audioPlayer.play('${timeInSec.value}-$voice.mp3');
      // }
      await Future.delayed(Duration(seconds: 1));
      if(this.mounted) {
        _timeInSec.value--;
      }
    }
  }

  void _startTimer() async {
    _timeInSec.value = 5;
    // if (isVoice!) {
    //   await audioPlayer.setAsset('assets/audio/$voice/5-$voice.mp3');
    //   audioPlayer.play();
    //   // audioPlayer.play('5-$voice.mp3');
    // }
    await Future.delayed(Duration(seconds: 1));
    _timeInSec.value = 4;
    // if (isVoice!) {
    //   await audioPlayer.setAsset('assets/audio/$voice/4-$voice.mp3');
    //   audioPlayer.play();
    // }
    await Future.delayed(Duration(seconds: 1));
    _timeInSec.value = 3;
    // if (isVoice!) {
    //   await audioPlayer.setAsset('assets/audio/$voice/3-$voice.mp3');
    //   audioPlayer.play();
    // }
    await Future.delayed(Duration(seconds: 1));
    _timeInSec.value = 2;
    // if (isVoice!) {
    //   await audioPlayer.setAsset('assets/audio/$voice/2-$voice.mp3');
    //   audioPlayer.play();
    // }
    await Future.delayed(Duration(seconds: 1));
    _timeInSec.value = 1;
    // if (isVoice!) {
    //   await audioPlayer.setAsset('assets/audio/$voice/1-$voice.mp3');
    //   audioPlayer.play();
    // }
    await Future.delayed(Duration(seconds: 1));
    for (int setIndex = 1; setIndex <= _timerSettings.sets; setIndex++) {
      _currentSet.value = setIndex;

      for (int repIndex = 1; repIndex <= _timerSettings.reps; repIndex++) {
        _currentRep.value = repIndex;

        for (int tempoIndex = 0;
            tempoIndex < _timerSettings.temposList.length;
            tempoIndex++) {

          _titleName.value = _timerSettings.temposList.elementAt(tempoIndex).key;
          var currentTempo = _timerSettings.temposList.elementAt(tempoIndex).value;
          _timeInSec.value = currentTempo;

          await _runTimer(_timeInSec.value);
        }
      }

      if(_timerSettings.rest != 0) {
        _timeInSec.value = _timerSettings.rest;
        _titleName.value = 'Rest';
        await _runTimer(_timeInSec.value);
      }

      // _currentRep.value = index + 1;
      // s = _timerSettings![index].sets;
      // for (_index.value = 1;
      //     _index.value <= _timerSettings![index].sets!;
      //     _index.value++) {
      //   for (int j = 0; j < _timerSettings!.[index].timeList!.length; j++) {
      //     // if (isVoice!) {
      //     //   await audioPlayer.setAsset(
      //     //       'assets/audio/$voice/${setList![index].timeList![j].isWork! ? 'start' : 'rest'}-$voice.mp3');
      //     //   audioPlayer.play();
      //     // }
      //     // if (isVoice!){
      //     //   audioPlayer.play(
      //     //       '${setList![index].timeList![j].isWork! ? 'start' : 'rest'}-$voice.mp3');
      //     _titleName.value =
      //         '${setList![index].grpName}${isRest! ? '' : '-'}${setList![index].timeList![j].name}';
      //     _timeInSec.value = setList![index].timeList![j].sec!;
      //     if (_timeInSec.value > 0)
      //       await _runTimer(setList![index].timeList![j].sec);
      //     if (_index.value != s && isRest!) {
      //       _titleName.value = breakT!.name!;
      //       _timeInSec.value = breakT!.sec!;
      //       // if (_index.value != s! + 1 && isVoice!) {
      //       //   await audioPlayer
      //       //       .setAsset('assets/audio/$voice/rest-$voice.mp3');
      //       //   audioPlayer.play();
      //       //   // audioPlayer.play('rest-$voice.mp3');
      //       // }
      //       if (_timeInSec.value > 0) await _runTimer(breakT!.sec);
      //     }
      //   }
      // }
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
