import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/models/timer_model_new.dart';
import 'package:focus/utilities/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_timer_view_model.freezed.dart';

@freezed
class CreateTimerState with _$CreateTimerState {
  const factory CreateTimerState({
    @Default(false) bool isTimerValid,
    TimerModelNew? timerModel,
}) = _CreateTimerState;

  const CreateTimerState._();
}

final createTimerViewModelProvider =
StateNotifierProvider.autoDispose<CreateTimerViewModel, CreateTimerState>(
      (ref) => CreateTimerViewModel(),
);

class CreateTimerViewModel extends StateNotifier<CreateTimerState> {
  CreateTimerViewModel() : super(const CreateTimerState()) { _init(); }

  Future<void> _init() async {
    state = CreateTimerState(isTimerValid: false, timerModel: TimerModelNew());
  }

  Future<void> setTimerName(String value) async {
    log.info('setTimerName: $value');
    final updatedTimerModel = state.timerModel!.copyWith(name: value);
    state = CreateTimerState(timerModel: updatedTimerModel);
  }
}