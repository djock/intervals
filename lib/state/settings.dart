import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  int _concentric = 2;
  int _concentricPause = 1;
  int _eccentric = 2;
  int _eccentricPause = 0;

  int _setsCount = 3;
  int _repsCount = 8;
  int _restTime = 90;

  int get concentric => _concentric;
  int get concentricPause => _concentricPause;
  int get eccentric => _eccentric;
  int get eccentricPause => _eccentricPause;
  int get repsCount => _repsCount;
  int get setsCount => _setsCount;
  int get restTime => _restTime;

  set concentric(int newValue) {
    _concentric = newValue;
    notifyListeners();
  }

  set concentricPause(int newValue) {
    _concentricPause = newValue;
    notifyListeners();
  }

  set eccentric(int newValue) {
    _eccentric = newValue;
    notifyListeners();
  }

  set eccentricPause(int newValue) {
    _eccentricPause = newValue;
    notifyListeners();
  }

  set repsCount(int newValue) {
    _repsCount = newValue;
    notifyListeners();
  }

  set restTime(int newValue) {
    _restTime = newValue;
    notifyListeners();
  }

  set setsCount(int newValue) {
    _setsCount = newValue;
    notifyListeners();
  }











  int _numRounds = 3;
  int _breathsPerRound = 2;
  int _holdTime = 120;
  int _speed = 6;

  int get numRounds => _numRounds;
  int get breathsPerRound => _breathsPerRound;
  int get holdTime => _holdTime;
  int get speed {
    return _speed;
  }

  set numRounds(int newValue) {
    _numRounds = newValue;
    notifyListeners();
  }

  set breathsPerRound(int newValue) {
    _breathsPerRound = newValue;
    notifyListeners();
  }

  set holdTime(int newValue) {
    _holdTime = newValue;
    notifyListeners();
  }

  set speed(int newValue) {
    _speed = newValue;
    notifyListeners();
  }
}
