import 'package:freezed_annotation/freezed_annotation.dart';

part 'interval_model.freezed.dart';
part 'interval_model.g.dart';

@freezed
class IntervalModel with _$IntervalModel {
  factory IntervalModel({
    required int index,
    @Default('Work') String name,
    @Default(5) int value,
  }) = _IntervalModel;

  factory IntervalModel.fromJson(Map<String, Object?> json) =>
      _$IntervalModelFromJson(json);
}