import 'dart:async';

import 'package:focus/models/index_key_value_pair_adapter.dart';
import 'package:focus/models/timer_model.dart';
import 'package:focus/models/timer_model_adapter.dart';
import 'package:focus/models/timer_type_enum_adapter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHandler {
  static void init() {
    Hive.registerAdapter(TimerModelAdapter());
    Hive.registerAdapter(IndexKeyValuePairAdapter());
    Hive.registerAdapter(TimerTypeEnumAdapter());
  }

  static Future<List<TimerModel>> openHiveBoxes() async {
    var timersList = <TimerModel>[];

    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    var hiveTimers = await Hive.openBox('timers');

    if (hiveTimers.isNotEmpty) {
      var _box = hiveTimers.get('timers');

      for (var item in _box) {
        timersList.add(item);
      }
    }

    return timersList;
  }

  static void saveTimersToBox(List<TimerModel> timers) {
    Box timersBox = Hive.box('timers');
    timersBox.put('timers', timers);
  }
}
