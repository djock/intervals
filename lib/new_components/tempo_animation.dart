import 'package:flutter/material.dart';

enum tempoState {
  eccentric,
  concentric,
  pause,
}

class TempoAnimation {
  TempoAnimation({
    @required TickerProvider vsync,
    double min = 0,
    double max = 1,

    int increaseDuration = 2,
    int eccentricPause = 0,
    int decreaseDuration = 2,
    int concentricPause = 0,

    Function onFinishEccentric,
    Function onFinishConcentric,
  }) {
    _animationController = AnimationController(vsync: vsync);

    var curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutSine);

    _state = tempoState.eccentric;
    _animationController.duration = getDuration(seconds: increaseDuration);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {

        _animationController.duration = getDuration(seconds: decreaseDuration);
        _animationController.reverse();
        _state = tempoState.concentric;

        if (onFinishEccentric != null) {
          onFinishEccentric();
        }
      } else if (status == AnimationStatus.dismissed) {
        _animationController.duration = getDuration(seconds: increaseDuration);

        _animationController.forward();
        _state = tempoState.eccentric;

        if (onFinishConcentric != null) {
          onFinishConcentric();
        }
      }
    });

    _tweenedAnimation = Tween<double>(begin: min, end: max).animate(curvedAnimation);
  }

  Animation _tweenedAnimation;
  AnimationController _animationController;
  tempoState _state;

  Duration getDuration({@required int seconds}) {
    return Duration(seconds: seconds);
  }

  double get value => _tweenedAnimation.value;

  tempoState get state => _state;

  void start() {
    _animationController.forward();
  }

  void stop() {
    _animationController.stop();
  }

  void addListener(Function listener) {
    _animationController.addListener(listener);
  }

  void dispose() {
    _animationController.dispose();
  }
}
