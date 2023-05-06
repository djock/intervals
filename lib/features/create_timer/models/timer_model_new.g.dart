// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_model_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimerModelNew _$$_TimerModelNewFromJson(Map<String, dynamic> json) =>
    _$_TimerModelNew(
      id: json['id'] as String?,
      date: json['date'] as int?,
      name: json['name'] as String?,
      sets: json['sets'] ?? 1,
      reps: json['reps'] ?? 1,
      time: json['time'] as int?,
      rest: json['rest'] ?? 60,
      intervals: (json['intervals'] as List<dynamic>?)
          ?.map((e) => IntervalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: $enumDecodeNullable(_$TimerTypeEnumMap, json['type']),
      iconIndex: json['iconIndex'] ?? 0,
    );

Map<String, dynamic> _$$_TimerModelNewToJson(_$_TimerModelNew instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'name': instance.name,
      'sets': instance.sets,
      'reps': instance.reps,
      'time': instance.time,
      'rest': instance.rest,
      'intervals': instance.intervals,
      'type': _$TimerTypeEnumMap[instance.type],
      'iconIndex': instance.iconIndex,
    };

const _$TimerTypeEnumMap = {
  TimerType.reps: 'reps',
  TimerType.time: 'time',
};
