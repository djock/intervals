import 'package:flutter/material.dart';
import 'package:focus/models/index_key_value_pair.dart';

class TimerSettings extends ChangeNotifier {
  int sets = 3;
  int reps = 8;
  int time = 300;
  int rest = 60;
  // Map<String,int> tempos = {};
  List<IndexKeyValuePair> intervals = [];
  int listCount = 0;

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

  void updateTotalTime(int newValue) {
    time = newValue;
    notifyListeners();
  }

  // void updateTempos(String text, int value) {
  //   tempos[text] = value;
  //   notifyListeners();
  // }

  void updateIntervals(int index, String text, int value) {
    var ikvp = new IndexKeyValuePair(index, text, value);

    if (intervals.any((element) => element.index == index)) {
      var tempoToUpdate =
          intervals.where((element) => element.index == index).first;

      if(value > 0) {
        tempoToUpdate.setValue(value);
      }
      else {
        intervals.remove(tempoToUpdate);
      }
    } else {
      intervals.add(ikvp);
      listCount++;
    }

    notifyListeners();
  }

  int getTotalTime() {
    var tempoTime = 0;
    for (var item in intervals) {
      tempoTime += item.value;
    }

    tempoTime += (sets - 1) * rest;

    return sets * reps * tempoTime;
  }
}
