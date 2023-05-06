import 'package:focus/models/timer_type_enum.dart';
import 'package:hive/hive.dart';

import '../utilities/utils.dart';
import 'index_key_value_pair.dart';
part 'timer_model.g.dart';

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
  @HiveField(7)
  TimerType type;
  @HiveField(8)
  String id;
  @HiveField(9)
  int date;

  TimerModel(this.name, this.sets, this.reps, this.time, this.rest,
      this.intervals, this.listCount, this.type, this.id, this.date);

  TimerModel.copy(TimerModel t)
      : name = t.name,
        sets = t.sets,
        reps = t.reps,
        time = t.time,
        rest = t.rest,
        intervals = t.intervals,
        type = t.type,
        listCount = t.listCount,
        id = t.id,
        date = t.date;

  int getTotalSeconds() {
    if (type == TimerType.reps) {
      var totalTime = 0;

      for (var item in intervals) {
        totalTime += item.value;
      }

      var result = (sets * reps * totalTime) + ((sets - 1) * rest);

      return result;
    } else {
      return time;
    }
  }

  void createMd5() {
    id = Utils.generateMd5(name);
  }

  void setDate() {
    date = DateTime.now().millisecondsSinceEpoch;
  }
}
