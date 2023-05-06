import 'package:hive/hive.dart';

part 'index_key_value_pair.g.dart';

@HiveType(typeId: 1)
class IndexKeyValuePair {
  @HiveField(0)
  int index;
  @HiveField(1)
  String key;
  @HiveField(2)
  int value;

  IndexKeyValuePair(this.index, this.key, this.value);

  void setValue(int newValue) {
    value = newValue;
  }
}
