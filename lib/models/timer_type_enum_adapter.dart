import 'package:focus/models/timer_type_enum.dart';
import 'package:hive/hive.dart';

class TimerTypeEnumAdapter extends TypeAdapter<TimerType> {
  @override
  final int typeId = 2;

  @override
  TimerType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TimerType.reps;
      case 1:
        return TimerType.time;
      default:
        return TimerType.reps;
    }
  }

  @override
  void write(BinaryWriter writer, TimerType obj) {
    switch (obj) {
      case TimerType.reps:
        writer.writeByte(0);
        break;
      case TimerType.time:
        writer.writeByte(1);
        break;
    }
  }
}