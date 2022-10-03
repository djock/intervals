import 'package:flutter/cupertino.dart';
import 'package:focus/handlers/hive_handler.dart';

import '../models/timer_model.dart';

class TimersManager extends ChangeNotifier {
  List<TimerModel> timers = <TimerModel>[];

  void getHiveTimers() {
    HiveHandler.openHiveBoxes().then((value) {
      timers = value;

      for (var timer in timers) {
        print(timer.name + ' ' + timer.sets.toString() + ' ' + timer.reps.toString() + ' ' + timer.time.toString() + ' ' + timer.rest.toString());
      }

      notifyListeners();
    });
  }

  void saveTimerToHive(TimerModel timer) {
    timers.add(timer);
    HiveHandler.saveTimersToBox(timers);
  }
}
