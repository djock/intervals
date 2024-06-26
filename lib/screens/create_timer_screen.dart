import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/edit_interval_bottom_sheet.dart';
import 'package:focus/screens/timer_screen.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/picker_config.dart';
import 'package:focus/providers/providers.dart';
import 'package:focus/screens/add_interval_bottom_sheet.dart';
import 'package:focus/widgets/notification_bar.dart';
import 'package:focus/widgets/row_text_icon_button.dart';

import '../utilities/custom_style.dart';
import '../utilities/utils.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/expanded_test_button.dart';
import '../widgets/picker_interval_item.dart';
import '../widgets/slider_interval_item.dart';
import 'pop_scope_screen.dart';

enum TimerType { reps, time }

class CreateTimerScreen extends ConsumerStatefulWidget {
  static const String id = 'CreateTimerScreen';

  @override
  CreateTimerScreenState createState() => CreateTimerScreenState();
}

class CreateTimerScreenState extends ConsumerState<CreateTimerScreen> {
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
    final activeTimerWatcher = ref.watch(activeTimerProvider);

    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.buildNormal(
            context, AppLocalizations.createTimerScreenTitle),
        body: Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // _buildIconAndInput(),
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
              ))),
              ExpandedTextButton(
                  text: AppLocalizations.saveTimer,
                  callback: () {
                    if (activeTimerWatcher.timer.intervals.isEmpty) {
                      NotificationBar.build(
                          context,
                          AppLocalizations.noTemposErrorTitle,
                          AppLocalizations.noTemposErrorMessage,
                          Theme.of(context).colorScheme.error);
                    } else {
                      var timersManager = ref.watch(timersManagerProvider);
                      timersManager.saveTimerToHive(activeTimerWatcher.timer);

                      // if (_formKey.currentState!.validate()) {
                      //   Navigator.of(context).pushNamed(TimerScreen.id);
                      // }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntervalsList(WidgetRef ref) {
    final activeTimerWatcher = ref.watch(activeTimerProvider);

    List<Widget> _tempos = [];

    for (var item in activeTimerWatcher.timer.intervals) {
      _tempos.add(new SliderIntervalItem(item.value, item.key, () {
        _openEditIntervalBottomSheet(ref, item.key, item.value, item.index);
      }, () {
        activeTimerWatcher.deleteInterval(item.index);
      }));

      _tempos.add(SizedBox(height: 10,));
    }

    _tempos.add(RowIconTextButton(
      callback: () {
        _openAddIntervalBottomSheet(ref);
      },
      text: AppLocalizations.addInterval,
      icon: Icons.add,
    ));

    return Column(
      children: _tempos,
    );
  }

  void _openAddIntervalBottomSheet(WidgetRef ref) {
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

  void _openEditIntervalBottomSheet(WidgetRef ref, String title, int value, int index) {
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

  Widget _buildIconAndInput() {
    return Row(
      children: [
        Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(
              'icon',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).hintColor),
            ))),
        SizedBox(width: 20.0),
        Expanded(
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textEditingController,
              style: Theme.of(context).textTheme.headline6,
              decoration: CustomStyle.inputDecoration(context),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.addTimerName;
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTimerTypeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.timerType,
            style: Theme.of(context).textTheme.headline6,
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              for (int i = 0; i < toggleStates.length; i++) {
                toggleStates[i] = i == index;

                if (i == index) {
                  if (_timerType != _timerTypes[i]) {
                    _timerType = _timerTypes[i];
                    setState(() {
                      log.info('Selected ' + _timerType.toString());
                    });
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
