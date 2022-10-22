import 'package:flutter/cupertino.dart';
import 'package:focus/handlers/hive_handler.dart';

import '../models/timer_model.dart';

class TimersManager extends ChangeNotifier {
  List<TimerModel> timers = <TimerModel>[];
  List<TimerModel> activities = <TimerModel>[];

  void getHiveTimers() {
    HiveHandler.openTimersBox().then((value) {
      timers = value;
      notifyListeners();
    });
  }

  void getHiveActivities() {
    HiveHandler.openActivitiesBox().then((value) {
      activities = value;
      notifyListeners();
    });
  }

  void saveTimerToHive(TimerModel timer) {
    timer.createMd5();

    timers.add(timer);
    HiveHandler.saveTimersToBox(timers);

    notifyListeners();
  }

  void saveActivitiesToHive(TimerModel timer) {
    timer.setDate();
    activities.add(timer);
    HiveHandler.saveActivitiesToBox(activities);

    notifyListeners();
  }

  void updateTimerInHive(TimerModel timer) {
    timers.removeWhere((element) => element.id == timer.id);

    timer.createMd5();
    timers.add(timer);
    HiveHandler.saveTimersToBox(timers);

    notifyListeners();
  }

  void deleteTimerFromHive(TimerModel timer) {
    timers.remove(timer);
    HiveHandler.saveTimersToBox(timers);

    notifyListeners();
  }
}
