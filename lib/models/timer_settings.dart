import 'package:flutter/material.dart';
import 'package:focus/models/index_key_value_pair.dart';

class TimerSettings extends ChangeNotifier {
  String name = '';
  int sets = 3;
  int reps = 8;
  int time = 300;
  int rest = 60;
  List<IndexKeyValuePair> intervals = [];
  int listCount = 0;

  TimerSettings();

  void updateName(String name) {
    this.name = name;
    notifyListeners();
  }

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

  void deleteInterval(int index) {
    var interval = intervals.firstWhere((element) => element.index == index);

    intervals.remove(interval);
    notifyListeners();
  }

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

  void updateInterval(int index, String text, int value) {
    var interval = intervals.firstWhere((element) => element.index == index);
    interval.key = text;
    interval.value = value;

    notifyListeners();
  }

  int getTotalSeconds() {
    var totalTime = 0;

    for (var item in intervals) {
      totalTime += item.value;
    }

    totalTime += (sets - 1) * rest;

    return sets * reps * totalTime;
  }
}
