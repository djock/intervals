import 'package:flutter/material.dart';
import 'package:focus/new_components/tempo_animation.dart';
import 'package:focus/new_components/tempo_circle.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import 'package:focus/state/settings.dart';
import 'package:focus/components/animated_widget_sequence.dart';

enum CentralWidget {
  breathingCircle,
  breatheInText,
  holdTimer1,
  holdTimer2,
}

class TempoScreen extends StatefulWidget {
  static const String id = 'TempoScreen';

  @override
  _TempoScreenState createState() => _TempoScreenState();
}

class _TempoScreenState extends State<TempoScreen>
    with SingleTickerProviderStateMixin {
  int roundsElapsed = 0;
  int timerDuration = 0;
  int repsDone = 0;

  CentralWidget centralWidget = CentralWidget.breathingCircle;
  DateTime startTime;

  TempoCircleController tempoCircleController = TempoCircleController();

  AnimatedSwitcherSequenceController animatedSwitcherSequenceController =
      AnimatedSwitcherSequenceController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.lightBlueAccent,
        ),
        title: Text(
          'BREATHE',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 25,
            letterSpacing: 3,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text('REP ' + repsDone.toString()),
            ),
            Expanded(
              child: Center(
                child: AnimatedSwitcherSequence(
                  controller: animatedSwitcherSequenceController,
                  beforeLoop: () {
                    Settings settings =
                        Provider.of<Settings>(context, listen: false);
                    roundsElapsed++;
                    repsDone = 1;

                    if (roundsElapsed >= settings.numRounds) {
                      Navigator.pop(context);
                    }
                  },
                  builders: [
                    (next) => _buildTimerWidget(git p
                        3, 'Get ready for set ${roundsElapsed + 1}', next),
                    (next) => _buildTempoCircle(() {}, () {
                          Settings settings =
                              Provider.of<Settings>(context, listen: false);

                          if (repsDone == settings.repsCount) {
                            next();
                          } else {
                            setState(() {
                              repsDone++;
                            });
                          }
                        }),
                    (next) {
                      Settings settings =
                          Provider.of<Settings>(context, listen: false);
                      return _buildTimerWidget(settings.restTime, 'REST', next);
                    },
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Center(
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    animatedSwitcherSequenceController.skipToNext();
                  },
                  child: Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTempoCircle(
      Function onFinishEccentric, Function onFinishConcentric) {
    return TempoCircle(
      controller: tempoCircleController,
      onFinishEccentric: onFinishEccentric,
      onFinishConcentric: onFinishConcentric,
      child: SlideCountdownClock(
        textStyle: TextStyle(
          fontSize: 50,
        ),
        shouldShowHours: false,
        separator: ':',
        duration: Duration(seconds: 5),
        onDone: null,
      ),
    );
  }

  Widget _buildTimerWidget(int holdTime, String text, Function onDone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text),
        SlideCountdownClock(
          textStyle: TextStyle(
            fontSize: 50,
          ),
          shouldShowHours: false,
          separator: ':',
          duration: Duration(seconds: holdTime),
          onDone: onDone,
        ),
      ],
    );
  }

  @override
  void dispose() {
    tempoCircleController.dispose();
    super.dispose();
  }
}
