import 'package:flutter/material.dart';
import 'package:focus/models/key_value_pair.dart';

class TimerSettings extends ChangeNotifier {
  int sets = 0;
  int reps = 0;
  int time = 0;
  int rest = 0;
  // Map<String,int> tempos = {};
  List<KeyValuePair> temposList = [];

  TimerSettings();

  void updateSets(int newValue) {
    sets = newValue;
    notifyListeners();
  }

  void updateReps(int newValue) {
    reps = newValue;
    notifyListeners();
  }

  void updateRest(int newValue) {
    rest = newValue;
    notifyListeners();
  }

  // void updateTempos(String text, int value) {
  //   tempos[text] = value;
  //   notifyListeners();
  // }

  void updateTemposList(String text, int value) {
    var kvp = new KeyValuePair(text, value);

    temposList.add(kvp);
    notifyListeners();
  }

  int getTotalTime() {
    var tempoTime = 0;
    for(var item in temposList) {
      tempoTime += item.value;
    }
    // temposList.forEach((key, value) { tempoTime += value; });

    return sets * reps * tempoTime;
  }
}