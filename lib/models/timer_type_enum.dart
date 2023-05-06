import 'package:hive/hive.dart';
part 'timer_type_enum.g.dart';

@HiveType(typeId: 2)
enum TimerType {
  @HiveField(0)
  reps,
  @HiveField(1)
  time
}
