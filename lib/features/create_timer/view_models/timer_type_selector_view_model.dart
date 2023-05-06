import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:focus/utilities/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_type_selector_view_model.freezed.dart';

@freezed
class TimerTypeSelectorState with _$TimerTypeSelectorState {
  const factory TimerTypeSelectorState({
    @Default(0)
        int selectedIndex,
    @Default(TimerType.reps)
        TimerType selectedTimerType,
    @Default(<bool>[true, false])
        List<bool> toggleStates,
    @Default(<TimerType>[
      TimerType.reps,
      TimerType.time,
    ])
        List<TimerType> timerTypes,
  }) = _TimerTypeSelectorState;

  const TimerTypeSelectorState._();
}

final timerTypeSelectorViewModelProvider = StateNotifierProvider.autoDispose<
    TimerTypeSelectorViewModel, TimerTypeSelectorState>(
  (ref) => TimerTypeSelectorViewModel(),
);

class TimerTypeSelectorViewModel extends StateNotifier<TimerTypeSelectorState> {
  TimerTypeSelectorViewModel() : super(const TimerTypeSelectorState());

  Future<void> setSelectedIndex(int value) async {
    state = TimerTypeSelectorState(selectedIndex: value);
  }

  Future<void> setSelectedTimerType(TimerType value) async {
    state = TimerTypeSelectorState(selectedTimerType: value);
  }

  Future<void> onTogglePressed(int index) async {
    var _toggleStates = List<bool>.from(state.toggleStates);

    if (_toggleStates[index]) {
      return;
    }

    _toggleStates = List.generate(_toggleStates.length, (i) => i == index);
    var timerType = state.timerTypes[index];

    state = state.copyWith(
      selectedIndex: index,
      selectedTimerType: timerType,
      toggleStates: _toggleStates,
    );
  }

}
