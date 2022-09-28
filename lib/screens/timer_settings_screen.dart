import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/timer_screen.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/providers.dart';
import 'package:focus/widgets/add_interval_bottom_sheet.dart';
import 'package:focus/widgets/notification_bar.dart';
import 'package:focus/widgets/row_text_icon_button.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/expanded_test_button.dart';
import '../widgets/rest_config_button.dart';
import '../widgets/tempo_list_item.dart';
import '../widgets/timer_config_button.dart';
import '../widgets/timer_config_empty_button.dart';

class TimerSettingsScreen extends StatefulWidget {
  static const String id = 'TimerSettingsScreen';

  @override
  TimerSettingsScreenState createState() => TimerSettingsScreenState();
}

class TimerSettingsScreenState extends State<TimerSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final timerSettings = ref.watch(timerSettingsNotifier);
        final themeSettings = ref.watch(appThemeStateNotifier);

        return Scaffold(
          appBar: CustomAppBar.buildWithAction(
              context, AppLocalizations.createTimerScreenTitle, [
            IconButton(
                icon: Icon(Icons.dark_mode_sharp),
                color: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  if (themeSettings.isDarkModeEnabled) {
                    themeSettings.setLightTheme();
                  } else {
                    themeSettings.setDarkTheme();
                  }
                })
          ]),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildSetWidget(ref),
                  _buildRepsWidget(ref),
                  _buildRestWidget(ref),
                ],
              ),
              Expanded(child: SingleChildScrollView(child: _buildTempos(ref))),
              ExpandedTextButton(
                  text: AppLocalizations.start,
                  callback: () {
                    if (timerSettings.intervals.isEmpty) {
                      NotificationBar.build(
                          context,
                          AppLocalizations.noTemposErrorTitle,
                          AppLocalizations.noTemposErrorMessage,
                          Theme.of(context).colorScheme.error);
                    } else {
                      activeTimerSettings = timerSettings;
                      Navigator.of(context).pushNamed(TimerScreen.id);
                    }
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSetWidget(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);

    if (timerSettings.sets != 0) {
      return TimerConfigButton(
        value: timerSettings.sets,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateSets(newValue);
        },
        title: AppLocalizations.sets,
      );
    } else {
      return TimerConfigEmptyButton(
        value: timerSettings.sets,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateSets(newValue);
        },
        title: AppLocalizations.addSets,
      );
    }
  }

  Widget _buildRepsWidget(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);

    if (timerSettings.reps != 0) {
      return TimerConfigButton(
        value: timerSettings.reps,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateReps(newValue);
        },
        title: AppLocalizations.reps,
      );
    } else {
      return TimerConfigEmptyButton(
        value: timerSettings.reps,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateReps(newValue);
        },
        title: AppLocalizations.addReps,
      );
    }
  }

  Widget _buildRestWidget(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);

    if (timerSettings.rest != 0) {
      return RestConfigButton(
        value: timerSettings.rest,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateRest(newValue);
        },
        title: AppLocalizations.rest,
      );
    } else {
      return TimerConfigEmptyButton(
        value: timerSettings.rest,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateRest(newValue);
        },
        title: AppLocalizations.addRest,
      );
    }
  }

  Widget _buildTempos(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);
    List<Widget> _tempos = [];

    for (var item in timerSettings.intervals) {
      _tempos.add(new TempoListItem(
        color: Theme.of(context).colorScheme.primary,
        title: item.key,
        value: item.value,
        onChanged: (newValue) {
          ref
              .read(timerSettingsNotifier)
              .updateIntervals(item.index, item.key, newValue);
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
            child: AddIntervalBottomSheet(callback: (text, value) {
              ref
                  .read(timerSettingsNotifier)
                  .updateIntervals(timerSettings.listCount, text, value);
              Navigator.pop(context);
            }));
      },
    );
  }
}
