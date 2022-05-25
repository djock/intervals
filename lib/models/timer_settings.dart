import 'package:flutter/material.dart';
import 'package:focus/models/index_key_value_pair.dart';

class TimerSettings extends ChangeNotifier {
  int sets = 0;
  int reps = 0;
  int time = 0;
  int rest = 0;
  // Map<String,int> tempos = {};
  List<IndexKeyValuePair> temposList = [];
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

  // void updateTempos(String text, int value) {
  //   tempos[text] = value;
  //   notifyListeners();
  // }

  void updateTemposList(int index, String text, int value) {
    var ikvp = new IndexKeyValuePair(index, text, value);

    if (temposList.any((element) => element.index == index)) {
      var tempoToUpdate =
          temposList.where((element) => element.index == index).first;

      if(value > 0) {
        tempoToUpdate.setValue(value);
      }
      else {
        temposList.remove(tempoToUpdate);
      }
    } else {
      temposList.add(ikvp);
      listCount++;
    }

    notifyListeners();
  }

  int getTotalTime() {
    var tempoTime = 0;
    for (var item in temposList) {
      tempoTime += item.value;
    }

    tempoTime += (sets - 1) * rest;

    return sets * reps * tempoTime;
  }
}
