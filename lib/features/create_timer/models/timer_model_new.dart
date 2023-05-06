import 'package:focus/features/create_timer/models/interval_model.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_model_new.freezed.dart';
part 'timer_model_new.g.dart';

@freezed
class TimerModelNew with _$TimerModelNew {
  factory TimerModelNew(
      {String? id,
      int? date,
      String? name,
      @Default(1) sets,
      @Default(1) reps,
      int? time,
      @Default(60) rest,
      List<IntervalModel>? intervals,
      TimerType? type,
      @Default(0) iconIndex}) = _TimerModelNew;

  factory TimerModelNew.fromJson(Map<String, Object?> json) =>
      _$TimerModelNewFromJson(json);
}
