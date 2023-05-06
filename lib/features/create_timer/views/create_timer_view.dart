import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/view_models/create_timer_view_model.dart';
import 'package:focus/features/create_timer/views/timer_icon_title_widget.dart';
import 'package:focus/modules/create_timer/picker_interval_item.dart';
import 'package:focus/modules/create_timer/edit_interval_bottom_sheet.dart';
import 'package:focus/modules/create_timer/slider_interval_item.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/picker_config.dart';
import 'package:focus/providers/providers.dart';
import 'package:focus/modules/create_timer/add_interval_bottom_sheet.dart';
import 'package:focus/modules/create_timer/row_text_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/timer_type_enum.dart';
import '../../../utilities/custom_style.dart';

class CreateTimerView extends ConsumerStatefulWidget {
  static const String id = 'CreateTimerScreen';

  @override
  CreateTimerViewState createState() => CreateTimerViewState();
}

class CreateTimerViewState extends ConsumerState<CreateTimerView> {
  List<Widget> _timerTypeTexts = <Widget>[
    Text(AppLocalizations.forReps),
    Text(AppLocalizations.forTime),
  ];

  List<TimerType> _timerTypes = <TimerType>[
    TimerType.reps,
    TimerType.time,
  ];

  TimerType _timerType = TimerType.reps;

  final _formKey = GlobalKey<FormState>();
  final List<bool> toggleStates = <bool>[true, false];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModelProvider = ref.watch(createTimerViewModelProvider.notifier);
    final viewModelState = ref.watch(createTimerViewModelProvider);

    return FractionallySizedBox(
      heightFactor: 0.93,
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF90A0AB).withOpacity(0.32),
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TimerIconTitleWidget(),
                          _buildTimerTypeSelector(),
                          _timerType == TimerType.reps
                              ? _buildTypeSetsReps()
                              : _buildTypeTime(),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildIntervalsList(ref),
                        ],
                      )),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildIntervalsList(WidgetRef ref) {
    final activeTimerWatcher = ref.watch(activeTimerProvider);

    List<Widget> _tempos = [];

    for (var item in activeTimerWatcher.timer.intervals) {
      _tempos.add(new SliderIntervalItem(item.value, item.key, () {
        _openEditIntervalBottomSheet(item.key, item.value, item.index);
      }, () {
        activeTimerWatcher.deleteInterval(item.index);
      }));

      _tempos.add(SizedBox(
        height: 10,
      ));
    }

    _tempos.add(RowIconTextButton(
      callback: () {
        _openAddIntervalBottomSheet();
      },
      text: AppLocalizations.addInterval,
      icon: Icons.add,
    ));

    return Column(
      children: _tempos,
    );
  }

  void _openAddIntervalBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: AddIntervalBottomSheet());
      },
    );
  }

  void _openEditIntervalBottomSheet(String title, int value, int index) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: EditIntervalBottomSheet(title, value, index));
      },
    );
  }

  List<String> list = <String>['1', '2', '3', '4'];


  Widget _buildTimerTypeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.timerType,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              for (int i = 0; i < toggleStates.length; i++) {
                toggleStates[i] = i == index;

                if (i == index) {
                  if (_timerType != _timerTypes[i]) {
                    _timerType = _timerTypes[i];
                    var activeTimerWatcher = ref.watch(activeTimerProvider);
                    activeTimerWatcher.updateType(_timerType);

                    setState(() {});
                  }
                }
              }
            },
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            selectedBorderColor: Theme.of(context).colorScheme.primary,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.primary,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 60.0,
            ),
            isSelected: toggleStates,
            children: _timerTypeTexts,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSetsReps() {
    final activeTimerWatcher = ref.watch(activeTimerProvider);

    return Column(
      children: [
        PickerIntervalItem(
          value: activeTimerWatcher.timer.sets,
          onChanged: (newValue) {
            if (newValue > 0) {
              activeTimerWatcher.updateSets(newValue);
            }
          },
          title: AppLocalizations.sets,
          config: PickerConfig.sets,
          canSlide: false,
        ),
        SizedBox(height: 10.0),
        PickerIntervalItem(
          value: activeTimerWatcher.timer.reps,
          onChanged: (newValue) {
            if (newValue > 0) {
              activeTimerWatcher.updateReps(newValue);
            }
          },
          title: AppLocalizations.reps,
          config: PickerConfig.sets,
          canSlide: false,
        ),
        SizedBox(height: 10.0),
        PickerIntervalItem(
          value: activeTimerWatcher.timer.rest,
          onChanged: (newValue) {
            activeTimerWatcher.updateRest(newValue);
          },
          title: AppLocalizations.rest,
          config: PickerConfig.totalTime,
          canSlide: false,
        )
      ],
    );
  }

  Widget _buildTypeTime() {
    final activeTimerWatcher = ref.watch(activeTimerProvider);

    return PickerIntervalItem(
      value: activeTimerWatcher.timer.time,
      onChanged: (newValue) {
        if (newValue > 0) {
          activeTimerWatcher.updateTotalTime(newValue);
        }
      },
      title: AppLocalizations.totalTime,
      config: PickerConfig.totalTime,
      canSlide: false,
    );
  }
}
