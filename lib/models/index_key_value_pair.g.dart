// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_key_value_pair.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndexKeyValuePairAdapter extends TypeAdapter<IndexKeyValuePair> {
  @override
  final int typeId = 1;

  @override
  IndexKeyValuePair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndexKeyValuePair(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, IndexKeyValuePair obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndexKeyValuePairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
