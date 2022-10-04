import 'package:hive/hive.dart';

import 'index_key_value_pair.dart';

@HiveType(typeId: 0)
class TimerModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int sets;
  @HiveField(2)
  int reps;
  @HiveField(3)
  int time;
  @HiveField(4)
  int rest;
  @HiveField(5)
  List<IndexKeyValuePair> intervals;
  @HiveField(6)
  int listCount;

  TimerModel(this.name, this.sets, this.reps, this.time, this.rest,
      this.intervals, this.listCount);

  TimerModel.copy(TimerModel t)
      : name = t.name,
        sets = t.sets,
        reps = t.reps,
        time = t.time,
        rest = t.rest,
        intervals = t.intervals,
        listCount = t.listCount;
}
