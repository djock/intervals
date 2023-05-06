// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interval_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IntervalModel _$IntervalModelFromJson(Map<String, dynamic> json) {
  return _IntervalModel.fromJson(json);
}

/// @nodoc
mixin _$IntervalModel {
  int get index => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntervalModelCopyWith<IntervalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntervalModelCopyWith<$Res> {
  factory $IntervalModelCopyWith(
          IntervalModel value, $Res Function(IntervalModel) then) =
      _$IntervalModelCopyWithImpl<$Res, IntervalModel>;
  @useResult
  $Res call({int index, String name, int value});
}

/// @nodoc
class _$IntervalModelCopyWithImpl<$Res, $Val extends IntervalModel>
    implements $IntervalModelCopyWith<$Res> {
  _$IntervalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IntervalModelCopyWith<$Res>
    implements $IntervalModelCopyWith<$Res> {
  factory _$$_IntervalModelCopyWith(
          _$_IntervalModel value, $Res Function(_$_IntervalModel) then) =
      __$$_IntervalModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, String name, int value});
}

/// @nodoc
class __$$_IntervalModelCopyWithImpl<$Res>
    extends _$IntervalModelCopyWithImpl<$Res, _$_IntervalModel>
    implements _$$_IntervalModelCopyWith<$Res> {
  __$$_IntervalModelCopyWithImpl(
      _$_IntervalModel _value, $Res Function(_$_IntervalModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? name = null,
    Object? value = null,
  }) {
    return _then(_$_IntervalModel(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IntervalModel implements _IntervalModel {
  _$_IntervalModel({required this.index, this.name = 'Work', this.value = 5});

  factory _$_IntervalModel.fromJson(Map<String, dynamic> json) =>
      _$$_IntervalModelFromJson(json);

  @override
  final int index;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int value;

  @override
  String toString() {
    return 'IntervalModel(index: $index, name: $name, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IntervalModel &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index, name, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IntervalModelCopyWith<_$_IntervalModel> get copyWith =>
      __$$_IntervalModelCopyWithImpl<_$_IntervalModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IntervalModelToJson(
      this,
    );
  }
}

abstract class _IntervalModel implements IntervalModel {
  factory _IntervalModel(
      {required final int index,
      final String name,
      final int value}) = _$_IntervalModel;

  factory _IntervalModel.fromJson(Map<String, dynamic> json) =
      _$_IntervalModel.fromJson;

  @override
  int get index;
  @override
  String get name;
  @override
  int get value;
  @override
  @JsonKey(ignore: true)
  _$$_IntervalModelCopyWith<_$_IntervalModel> get copyWith =>
      throw _privateConstructorUsedError;
}
