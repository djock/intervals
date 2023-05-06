// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_timer_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateTimerState {
  bool get isTimerValid => throw _privateConstructorUsedError;
  TimerModelNew? get timerModel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateTimerStateCopyWith<CreateTimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTimerStateCopyWith<$Res> {
  factory $CreateTimerStateCopyWith(
          CreateTimerState value, $Res Function(CreateTimerState) then) =
      _$CreateTimerStateCopyWithImpl<$Res, CreateTimerState>;
  @useResult
  $Res call({bool isTimerValid, TimerModelNew? timerModel});

  $TimerModelNewCopyWith<$Res>? get timerModel;
}

/// @nodoc
class _$CreateTimerStateCopyWithImpl<$Res, $Val extends CreateTimerState>
    implements $CreateTimerStateCopyWith<$Res> {
  _$CreateTimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTimerValid = null,
    Object? timerModel = freezed,
  }) {
    return _then(_value.copyWith(
      isTimerValid: null == isTimerValid
          ? _value.isTimerValid
          : isTimerValid // ignore: cast_nullable_to_non_nullable
              as bool,
      timerModel: freezed == timerModel
          ? _value.timerModel
          : timerModel // ignore: cast_nullable_to_non_nullable
              as TimerModelNew?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TimerModelNewCopyWith<$Res>? get timerModel {
    if (_value.timerModel == null) {
      return null;
    }

    return $TimerModelNewCopyWith<$Res>(_value.timerModel!, (value) {
      return _then(_value.copyWith(timerModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CreateTimerStateCopyWith<$Res>
    implements $CreateTimerStateCopyWith<$Res> {
  factory _$$_CreateTimerStateCopyWith(
          _$_CreateTimerState value, $Res Function(_$_CreateTimerState) then) =
      __$$_CreateTimerStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isTimerValid, TimerModelNew? timerModel});

  @override
  $TimerModelNewCopyWith<$Res>? get timerModel;
}

/// @nodoc
class __$$_CreateTimerStateCopyWithImpl<$Res>
    extends _$CreateTimerStateCopyWithImpl<$Res, _$_CreateTimerState>
    implements _$$_CreateTimerStateCopyWith<$Res> {
  __$$_CreateTimerStateCopyWithImpl(
      _$_CreateTimerState _value, $Res Function(_$_CreateTimerState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTimerValid = null,
    Object? timerModel = freezed,
  }) {
    return _then(_$_CreateTimerState(
      isTimerValid: null == isTimerValid
          ? _value.isTimerValid
          : isTimerValid // ignore: cast_nullable_to_non_nullable
              as bool,
      timerModel: freezed == timerModel
          ? _value.timerModel
          : timerModel // ignore: cast_nullable_to_non_nullable
              as TimerModelNew?,
    ));
  }
}

/// @nodoc

class _$_CreateTimerState extends _CreateTimerState {
  const _$_CreateTimerState({this.isTimerValid = false, this.timerModel})
      : super._();

  @override
  @JsonKey()
  final bool isTimerValid;
  @override
  final TimerModelNew? timerModel;

  @override
  String toString() {
    return 'CreateTimerState(isTimerValid: $isTimerValid, timerModel: $timerModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateTimerState &&
            (identical(other.isTimerValid, isTimerValid) ||
                other.isTimerValid == isTimerValid) &&
            (identical(other.timerModel, timerModel) ||
                other.timerModel == timerModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isTimerValid, timerModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateTimerStateCopyWith<_$_CreateTimerState> get copyWith =>
      __$$_CreateTimerStateCopyWithImpl<_$_CreateTimerState>(this, _$identity);
}

abstract class _CreateTimerState extends CreateTimerState {
  const factory _CreateTimerState(
      {final bool isTimerValid,
      final TimerModelNew? timerModel}) = _$_CreateTimerState;
  const _CreateTimerState._() : super._();

  @override
  bool get isTimerValid;
  @override
  TimerModelNew? get timerModel;
  @override
  @JsonKey(ignore: true)
  _$$_CreateTimerStateCopyWith<_$_CreateTimerState> get copyWith =>
      throw _privateConstructorUsedError;
}
