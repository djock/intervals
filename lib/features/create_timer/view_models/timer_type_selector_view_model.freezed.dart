// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_type_selector_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimerTypeSelectorState {
  int get selectedIndex => throw _privateConstructorUsedError;
  TimerType get selectedTimerType => throw _privateConstructorUsedError;
  List<bool> get toggleStates => throw _privateConstructorUsedError;
  List<TimerType> get timerTypes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerTypeSelectorStateCopyWith<TimerTypeSelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerTypeSelectorStateCopyWith<$Res> {
  factory $TimerTypeSelectorStateCopyWith(TimerTypeSelectorState value,
          $Res Function(TimerTypeSelectorState) then) =
      _$TimerTypeSelectorStateCopyWithImpl<$Res, TimerTypeSelectorState>;
  @useResult
  $Res call(
      {int selectedIndex,
      TimerType selectedTimerType,
      List<bool> toggleStates,
      List<TimerType> timerTypes});
}

/// @nodoc
class _$TimerTypeSelectorStateCopyWithImpl<$Res,
        $Val extends TimerTypeSelectorState>
    implements $TimerTypeSelectorStateCopyWith<$Res> {
  _$TimerTypeSelectorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
    Object? selectedTimerType = null,
    Object? toggleStates = null,
    Object? timerTypes = null,
  }) {
    return _then(_value.copyWith(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedTimerType: null == selectedTimerType
          ? _value.selectedTimerType
          : selectedTimerType // ignore: cast_nullable_to_non_nullable
              as TimerType,
      toggleStates: null == toggleStates
          ? _value.toggleStates
          : toggleStates // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      timerTypes: null == timerTypes
          ? _value.timerTypes
          : timerTypes // ignore: cast_nullable_to_non_nullable
              as List<TimerType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimerTypeSelectorStateCopyWith<$Res>
    implements $TimerTypeSelectorStateCopyWith<$Res> {
  factory _$$_TimerTypeSelectorStateCopyWith(_$_TimerTypeSelectorState value,
          $Res Function(_$_TimerTypeSelectorState) then) =
      __$$_TimerTypeSelectorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int selectedIndex,
      TimerType selectedTimerType,
      List<bool> toggleStates,
      List<TimerType> timerTypes});
}

/// @nodoc
class __$$_TimerTypeSelectorStateCopyWithImpl<$Res>
    extends _$TimerTypeSelectorStateCopyWithImpl<$Res,
        _$_TimerTypeSelectorState>
    implements _$$_TimerTypeSelectorStateCopyWith<$Res> {
  __$$_TimerTypeSelectorStateCopyWithImpl(_$_TimerTypeSelectorState _value,
      $Res Function(_$_TimerTypeSelectorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
    Object? selectedTimerType = null,
    Object? toggleStates = null,
    Object? timerTypes = null,
  }) {
    return _then(_$_TimerTypeSelectorState(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedTimerType: null == selectedTimerType
          ? _value.selectedTimerType
          : selectedTimerType // ignore: cast_nullable_to_non_nullable
              as TimerType,
      toggleStates: null == toggleStates
          ? _value._toggleStates
          : toggleStates // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      timerTypes: null == timerTypes
          ? _value._timerTypes
          : timerTypes // ignore: cast_nullable_to_non_nullable
              as List<TimerType>,
    ));
  }
}

/// @nodoc

class _$_TimerTypeSelectorState extends _TimerTypeSelectorState {
  const _$_TimerTypeSelectorState(
      {this.selectedIndex = 0,
      this.selectedTimerType = TimerType.reps,
      final List<bool> toggleStates = const <bool>[true, false],
      final List<TimerType> timerTypes = const <TimerType>[
        TimerType.reps,
        TimerType.time
      ]})
      : _toggleStates = toggleStates,
        _timerTypes = timerTypes,
        super._();

  @override
  @JsonKey()
  final int selectedIndex;
  @override
  @JsonKey()
  final TimerType selectedTimerType;
  final List<bool> _toggleStates;
  @override
  @JsonKey()
  List<bool> get toggleStates {
    if (_toggleStates is EqualUnmodifiableListView) return _toggleStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toggleStates);
  }

  final List<TimerType> _timerTypes;
  @override
  @JsonKey()
  List<TimerType> get timerTypes {
    if (_timerTypes is EqualUnmodifiableListView) return _timerTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timerTypes);
  }

  @override
  String toString() {
    return 'TimerTypeSelectorState(selectedIndex: $selectedIndex, selectedTimerType: $selectedTimerType, toggleStates: $toggleStates, timerTypes: $timerTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerTypeSelectorState &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.selectedTimerType, selectedTimerType) ||
                other.selectedTimerType == selectedTimerType) &&
            const DeepCollectionEquality()
                .equals(other._toggleStates, _toggleStates) &&
            const DeepCollectionEquality()
                .equals(other._timerTypes, _timerTypes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedIndex,
      selectedTimerType,
      const DeepCollectionEquality().hash(_toggleStates),
      const DeepCollectionEquality().hash(_timerTypes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimerTypeSelectorStateCopyWith<_$_TimerTypeSelectorState> get copyWith =>
      __$$_TimerTypeSelectorStateCopyWithImpl<_$_TimerTypeSelectorState>(
          this, _$identity);
}

abstract class _TimerTypeSelectorState extends TimerTypeSelectorState {
  const factory _TimerTypeSelectorState(
      {final int selectedIndex,
      final TimerType selectedTimerType,
      final List<bool> toggleStates,
      final List<TimerType> timerTypes}) = _$_TimerTypeSelectorState;
  const _TimerTypeSelectorState._() : super._();

  @override
  int get selectedIndex;
  @override
  TimerType get selectedTimerType;
  @override
  List<bool> get toggleStates;
  @override
  List<TimerType> get timerTypes;
  @override
  @JsonKey(ignore: true)
  _$$_TimerTypeSelectorStateCopyWith<_$_TimerTypeSelectorState> get copyWith =>
      throw _privateConstructorUsedError;
}
