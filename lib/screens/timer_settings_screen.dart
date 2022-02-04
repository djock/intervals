import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/timer_screen.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/providers.dart';
import 'package:focus/widgets/add_button.dart';
import 'package:focus/widgets/create_tempo_widget.dart';
import 'package:focus/widgets/tempo_item.dart';
import 'package:focus/widgets/wide_button.dart';

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
        // final isDark = ref.watch(isDarkThemeProvider);
        final timerSettings = ref.watch(timerSettingsNotifier);

        return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.timerSettingsScreenTitle),
                ),
                body: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSetWidget(ref),
                      _buildRepsWidget(ref),
                      _buildRestWidget(ref),
                      _buildTempos(ref),
                      WideButton(
                          value: 0,
                          onChanged: (newValue) {
                            _openBottomSheet(ref);
                          },
                          title: AppLocalizations.addTempo),
                      AddButton(callback: () {
                        activeTimerSettings = timerSettings;
                        Navigator.of(context).pushNamed(TimerScreen.id);
                      })
                    ],
                  )),
                )));
      },
    );
  }

  Widget _buildSetWidget(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);

    if (timerSettings.sets != 0) {
      return TempoItem(
        value: timerSettings.sets,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateSets(newValue);
        },
        title: AppLocalizations.sets,
      );
    } else {
      return WideButton(
        value: timerSettings.sets,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateSets(newValue);
          setState(() {});
        },
        title: AppLocalizations.addSets,
      );
    }
  }

  Widget _buildRepsWidget(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);

    if (timerSettings.reps != 0) {
      return TempoItem(
        value: timerSettings.reps,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateReps(newValue);
        },
        title: AppLocalizations.reps,
      );
    } else {
      return WideButton(
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
      return TempoItem(
        value: timerSettings.rest,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateRest(newValue);
        },
        title: AppLocalizations.rest,
      );
    } else {
      return WideButton(
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

    for(var item in timerSettings.temposList) {
      _tempos.add(new TempoItem(
        title: item.key,
        value: item.value,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateTemposList(item.key, newValue);
        },
      ));
    }

    return Column(
      children: _tempos,
    );
  }

  void _openBottomSheet(WidgetRef ref) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: CreateTempoWidget(callback: (text, value) {
              ref.read(timerSettingsNotifier).updateTemposList(text, value);
              Navigator.pop(context);
            }));
      },
    );
  }
}
