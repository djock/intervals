import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/timer_screen.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/providers.dart';
import 'package:focus/widgets/create_tempo_widget.dart';
import 'package:focus/widgets/notification_bar.dart';
import 'package:focus/widgets/row_text_icon_button.dart';

import '../utilities/logger.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/expanded_test_button.dart';
import '../widgets/interval_item.dart';
import '../widgets/picker_interval_item.dart';
import '../widgets/tempo_list_item.dart';
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
    final timerSettings = ref.watch(timerSettingsNotifier);

    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.buildNormal(
            context, AppLocalizations.createTimerScreenTitle),
        body: Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildIconAndInput(),
              _buildTimerTypeSelector(),
              _timerType == TimerType.reps ? _buildTypeReps() : _buildTypeTime(),
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
              Expanded(child: SingleChildScrollView(child: _buildTempos(ref))),
              ExpandedTextButton(
                  text: AppLocalizations.saveTimer,
                  callback: () {
                    if (timerSettings.temposList.isEmpty) {
                      NotificationBar.build(
                          context,
                          AppLocalizations.noTemposErrorTitle,
                          AppLocalizations.noTemposErrorMessage,
                          Theme.of(context).colorScheme.error);
                    } else {
                      if (_formKey.currentState!.validate()) {
                        NotificationBar.build(
                            context,
                            AppLocalizations.noTemposErrorTitle,
                            AppLocalizations.noTemposErrorMessage,
                            Theme.of(context).colorScheme.error);
                      } else {
                        activeTimerSettings = timerSettings;
                        Navigator.of(context).pushNamed(TimerScreen.id);
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTempos(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);
    List<Widget> _tempos = [];

    for (var item in timerSettings.temposList) {
      _tempos.add(new TempoListItem(
        color: Theme.of(context).colorScheme.primary,
        title: item.key,
        value: item.value,
        onChanged: (newValue) {
          ref
              .read(timerSettingsNotifier)
              .updateTemposList(item.index, item.key, newValue);
        },
      ));
    }

    _tempos.add(RowIconTextButton(
      callback: () {
        _openBottomSheet(ref);
      },
      text: AppLocalizations.addTempo,
      icon: Icons.add,
    ));

    return Column(
      children: _tempos,
    );
  }

  void _openBottomSheet(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: CreateTempoWidget(callback: (text, value) {
              ref
                  .read(timerSettingsNotifier)
                  .updateTemposList(timerSettings.listCount, text, value);
              Navigator.pop(context);
            }));
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
              style: Theme.of(context).textTheme.headline6,
            ))),
        SizedBox(width: 20.0),
        Expanded(
          child: TextFormField(
            controller: _textEditingController,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              hintText: AppLocalizations.addNameHere,
                hintStyle: Theme.of(context).textTheme.headline6,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        width: 0.2,
                        color: Theme.of(context).colorScheme.secondary))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
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
                  if(_timerType != _timerTypes[i]) {
                    _timerType = _timerTypes[i];
                    setState(() {
                      logger.info('Selected ' + _timerType.toString());
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

  Widget _buildTypeReps() {
    final timerSettingsWatcher = ref.watch(timerSettingsNotifier);

    return Column(
      children: [
        IntervalItem(
          value: timerSettingsWatcher.sets,
          onChanged: (newValue) {
            if(newValue > 0) {
              timerSettingsWatcher.updateSets(newValue);
            }
          },
          title: AppLocalizations.sets,
        ),
        IntervalItem(
          value: timerSettingsWatcher.reps,
          onChanged: (newValue) {
            if(newValue > 0) {
              timerSettingsWatcher.updateReps(newValue);
            }
          },
          title: AppLocalizations.reps,
        ),
        PickerIntervalItem(
          value: timerSettingsWatcher.rest,
          onChanged: (newValue) {
            if(newValue > 0) {
              timerSettingsWatcher.updateRest(newValue);
            }
          },
          title: AppLocalizations.rest,
        )
      ],
    );
  }

  Widget _buildTypeTime() {
    final timerSettingsWatcher = ref.watch(timerSettingsNotifier);

    return PickerIntervalItem(
      value: timerSettingsWatcher.time,
      onChanged: (newValue) {
        if(newValue > 0) {
          timerSettingsWatcher.updateTotalTime(newValue);
        }
      },
      title: AppLocalizations.totalTime,
    );
  }
}
