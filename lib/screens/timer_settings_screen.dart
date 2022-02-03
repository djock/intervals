import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/utilities/providers.dart';
import 'package:focus/widgets/tempo_item.dart';
import 'package:focus/widgets/wide_button.dart';

class TimerSettingsScreen extends StatefulWidget {
  static const String id = 'ConfigurationScreen';

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
                  title: Text('Tempo'),
                ),
                body: SingleChildScrollView(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSetWidget(ref),
                      _buildRepsWidget(ref),
                      _buildTempos(ref),
                      WideButton(
                          value: 0,
                          onChanged: (newValue) {
                            ref.read(timerSettingsNotifier).updateTempos('Tempo '+(timerSettings.tempos.length+1).toString(), 0);
                            setState(() {

                            });
                          },
                          title: 'Add Tempo')
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
        title: 'Sets',
      );
    } else {
      return WideButton(
        value: timerSettings.sets,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateSets(newValue);
          setState(() {});
        },
        title: 'Add Sets',
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
        title: 'Reps',
      );
    } else {
      return WideButton(
        value: timerSettings.reps,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateReps(newValue);
          setState(() {});
        },
        title: 'Add Reps',
      );
    }
  }

  Widget _buildTempos(WidgetRef ref) {
    final timerSettings = ref.watch(timerSettingsNotifier);

    List<Widget> _tempos =
        List.generate(timerSettings.tempos.length, (index) => SizedBox());

    timerSettings.tempos.forEach((key, value) {
      _tempos.add(new TempoItem(
        title: key,
        value: value,
        onChanged: (newValue) {
          ref.read(timerSettingsNotifier).updateTempos(key, newValue);
          setState(() {});
        },
      ));
    });

    return Column(
      children: _tempos,
    );
  }
}
