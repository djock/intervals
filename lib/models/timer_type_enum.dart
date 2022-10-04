import 'package:hive/hive.dart';

@HiveType(typeId: 2)
enum TimerType {
  @HiveField(0)
  reps,
  @HiveField(1)
  time
}
