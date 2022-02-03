import 'package:flutter/material.dart';

class TimerSettings extends ChangeNotifier {
  int sets = 0;
  int reps = 0;
  int time = 0;
  Map<String,int> tempos = {};

  void updateSets(int newValue) {
    sets = newValue;
    notifyListeners();
  }

  void updateReps(int newValue) {
    reps = newValue;
    notifyListeners();
  }

  void updateTempos(String text, int value) {
    tempos[text] = value;
    notifyListeners();
  }
}