import 'package:focus/models/timer_model.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:hive/hive.dart';

import 'index_key_value_pair.dart';

class TimerModelAdapter extends TypeAdapter<TimerModel> {
  @override
  TimerModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return TimerModel(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as int,
      (fields[5] as List).cast<IndexKeyValuePair>(),
      fields[6] as int,
      fields[7] as TimerType,
      fields[8] as String,
      fields[9] as int,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, TimerModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sets)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.rest)
      ..writeByte(5)
      ..write(obj.intervals)
      ..writeByte(6)
      ..write(obj.listCount)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.date);
  }
}
