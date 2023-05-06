import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_icon_view_model.freezed.dart';

@freezed
class TimerIconState with _$TimerIconState {
  const factory TimerIconState({
    @Default(0) int selectedIconIndex,
    @Default(false) bool showIconSelector,
  }) = _TimerIconTitleState;

  const TimerIconState._();
}

final timerIconViewModelProvider =
    StateNotifierProvider.autoDispose<TimerIconViewModel, TimerIconState>(
  (ref) => TimerIconViewModel(),
);

class TimerIconViewModel extends StateNotifier<TimerIconState> {
  TimerIconViewModel() : super(const TimerIconState());

  Future<void> setSelectedIconIndex(int value) async {
    state = TimerIconState(selectedIconIndex: value);
  }

  Future<void> setShowIconSelector(bool value) async {
    state = TimerIconState(showIconSelector: value);
  }
}
