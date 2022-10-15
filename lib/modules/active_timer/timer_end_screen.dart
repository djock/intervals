import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/models/timer_model.dart';

import '../../providers/providers.dart';
import '../../utilities/localizations.dart';
import '../../utilities/utils.dart';

class TimerEndScreen extends ConsumerStatefulWidget {
  static String id = 'TimerEndScreen';

  TimerEndScreen();

  @override
  TimerEndScreenState createState() => TimerEndScreenState();
}

class TimerEndScreenState extends ConsumerState<TimerEndScreen> {
  ConfettiController? _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    _confettiController!.dispose();
    super.dispose();
  }

  Path _drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Future<Null> _startCountdown() async {
    const timeOut = const Duration(milliseconds: 500);
    new Timer(timeOut, () {
      setState(() {
        _confettiController!.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeTimerInstance = ref.watch(activeTimerProvider);
    var timer = activeTimerInstance.timer;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                activeTimerInstance.clear();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.getCongrats(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _buildDetails(timer),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController!,
              blastDirectionality: BlastDirectionality.explosive,
              // don't specify a direction, blast randomly
              shouldLoop: true,
              // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
              // manually specify the colors to be used
              createParticlePath: _drawStar, // define a custom shape/path.
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Text(
                AppLocalizations.tapToClose,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(TimerModel timer) {
    List<Widget> widgets = [];

    widgets.add(Text(
      AppLocalizations.getLocalization(AppLocalizations.youHaveCompleted, '{TIMER_NAME}', timer.name),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    ));

    widgets.add(SizedBox(
      height: 10,
    ));

    widgets.add(Text(
      AppLocalizations.totalTime + ': ' + Utils.formatTime(timer.getTotalSeconds()),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    ));

    widgets.add(SizedBox(
      height: 10,
    ));

    widgets.add(Text(
      AppLocalizations.intervals + ': ',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline6,
    ));

    for(var item in timer.intervals) {
      widgets.add(Text(
        '· ' + item.key + ': ' + Utils.formatTime(item.value),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
