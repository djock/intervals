import 'package:hive/hive.dart';

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