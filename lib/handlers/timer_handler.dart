import 'package:flutter/cupertino.dart';
import 'package:focus/models/timer_type_enum.dart';

import '../models/index_key_value_pair.dart';
import '../models/timer_model.dart';
import '../utilities/utils.dart';

class ActiveTimer extends ChangeNotifier {
  TimerModel? _timer = new TimerModel('', 3, 8, 300, 60, [], 0, TimerType.reps,
      '', DateTime.now().millisecondsSinceEpoch);
  TimerModel get timer => _timer!;

  ActiveTimer();

  void clear() {
    _timer = new TimerModel('', 3, 8, 300, 60, [], 0, TimerType.reps, '',
        DateTime.now().millisecondsSinceEpoch);
    notifyListeners();
  }

  void setTimer(TimerModel timerModel) {
    _timer = timerModel;
    notifyListeners();
  }

  void createMd5() {
    _timer!.id = Utils.generateMd5(timer.name);
    notifyListeners();
  }

  void updateType(TimerType timerType) {
    _timer!.type = timerType;
    notifyListeners();
  }

  void updateName(String name) {
    _timer!.name = name;
    notifyListeners();
  }

  void updateSets(int newValue) {
    _timer!.sets = newValue;
    notifyListeners();
  }

  void updateReps(int newValue) {
    _timer!..reps = newValue;
    notifyListeners();
  }

  void updateRest(int newValue) {
    _timer!.rest = newValue;
    notifyListeners();
  }

  void updateTotalTime(int newValue) {
    _timer!.time = newValue;
    notifyListeners();
  }

  void deleteInterval(int index) {
    var _ = _timer!;

    var interval = _.intervals.firstWhere((element) => element.index == index);

    _.intervals.remove(interval);
    notifyListeners();
  }

  void updateIntervals(int index, String text, int value) {
    var ikvp = new IndexKeyValuePair(index, text, value);

    if (_timer!.intervals.any((element) => element.index == index)) {
      var tempoToUpdate =
          _timer!.intervals.where((element) => element.index == index).first;

      if (value > 0) {
        tempoToUpdate.setValue(value);
      } else {
        _timer!.intervals.remove(tempoToUpdate);
      }
    } else {
      _timer!.intervals.add(ikvp);
      _timer!.listCount++;
    }

    notifyListeners();
  }

  void updateInterval(int index, String text, int value) {
    var interval =
        _timer!.intervals.firstWhere((element) => element.index == index);
    interval.key = text;
    interval.value = value;

    notifyListeners();
  }
}
