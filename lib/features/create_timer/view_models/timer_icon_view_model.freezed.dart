// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_icon_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimerIconState {
  int get selectedIconIndex => throw _privateConstructorUsedError;
  bool get showIconSelector => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerIconStateCopyWith<TimerIconState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerIconStateCopyWith<$Res> {
  factory $TimerIconStateCopyWith(
          TimerIconState value, $Res Function(TimerIconState) then) =
      _$TimerIconStateCopyWithImpl<$Res, TimerIconState>;
  @useResult
  $Res call({int selectedIconIndex, bool showIconSelector});
}

/// @nodoc
class _$TimerIconStateCopyWithImpl<$Res, $Val extends TimerIconState>
    implements $TimerIconStateCopyWith<$Res> {
  _$TimerIconStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIconIndex = null,
    Object? showIconSelector = null,
  }) {
    return _then(_value.copyWith(
      selectedIconIndex: null == selectedIconIndex
          ? _value.selectedIconIndex
          : selectedIconIndex // ignore: cast_nullable_to_non_nullable
              as int,
      showIconSelector: null == showIconSelector
          ? _value.showIconSelector
          : showIconSelector // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimerIconTitleStateCopyWith<$Res>
    implements $TimerIconStateCopyWith<$Res> {
  factory _$$_TimerIconTitleStateCopyWith(_$_TimerIconTitleState value,
          $Res Function(_$_TimerIconTitleState) then) =
      __$$_TimerIconTitleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedIconIndex, bool showIconSelector});
}

/// @nodoc
class __$$_TimerIconTitleStateCopyWithImpl<$Res>
    extends _$TimerIconStateCopyWithImpl<$Res, _$_TimerIconTitleState>
    implements _$$_TimerIconTitleStateCopyWith<$Res> {
  __$$_TimerIconTitleStateCopyWithImpl(_$_TimerIconTitleState _value,
      $Res Function(_$_TimerIconTitleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIconIndex = null,
    Object? showIconSelector = null,
  }) {
    return _then(_$_TimerIconTitleState(
      selectedIconIndex: null == selectedIconIndex
          ? _value.selectedIconIndex
          : selectedIconIndex // ignore: cast_nullable_to_non_nullable
              as int,
      showIconSelector: null == showIconSelector
          ? _value.showIconSelector
          : showIconSelector // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TimerIconTitleState extends _TimerIconTitleState {
  const _$_TimerIconTitleState(
      {this.selectedIconIndex = 0, this.showIconSelector = false})
      : super._();

  @override
  @JsonKey()
  final int selectedIconIndex;
  @override
  @JsonKey()
  final bool showIconSelector;

  @override
  String toString() {
    return 'TimerIconState(selectedIconIndex: $selectedIconIndex, showIconSelector: $showIconSelector)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerIconTitleState &&
            (identical(other.selectedIconIndex, selectedIconIndex) ||
                other.selectedIconIndex == selectedIconIndex) &&
            (identical(other.showIconSelector, showIconSelector) ||
                other.showIconSelector == showIconSelector));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedIconIndex, showIconSelector);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimerIconTitleStateCopyWith<_$_TimerIconTitleState> get copyWith =>
      __$$_TimerIconTitleStateCopyWithImpl<_$_TimerIconTitleState>(
          this, _$identity);
}

abstract class _TimerIconTitleState extends TimerIconState {
  const factory _TimerIconTitleState(
      {final int selectedIconIndex,
      final bool showIconSelector}) = _$_TimerIconTitleState;
  const _TimerIconTitleState._() : super._();

  @override
  int get selectedIconIndex;
  @override
  bool get showIconSelector;
  @override
  @JsonKey(ignore: true)
  _$$_TimerIconTitleStateCopyWith<_$_TimerIconTitleState> get copyWith =>
      throw _privateConstructorUsedError;
}
