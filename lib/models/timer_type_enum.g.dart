// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerTypeAdapter extends TypeAdapter<TimerType> {
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
