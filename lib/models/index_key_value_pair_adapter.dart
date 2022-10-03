import 'package:hive/hive.dart';

import 'index_key_value_pair.dart';

class IndexKeyValuePairAdapter extends TypeAdapter<IndexKeyValuePair> {
  @override
  IndexKeyValuePair read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndexKeyValuePair(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
    );
  }

  @override
  int get typeId => 1;

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
}
