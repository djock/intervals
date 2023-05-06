import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/view_models/timer_type_selector_view_model.dart';
import 'package:focus/utilities/localizations.dart';

class TimerTypeSelectorWidget extends ConsumerWidget {
  final List<Widget> _timerTypeTexts = <Widget>[
    Text(AppLocalizations.forReps),
    Text(AppLocalizations.forTime),
  ];

  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(timerTypeSelectorViewModelProvider.notifier);
    final viewModelState = ref.watch(timerTypeSelectorViewModelProvider);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the width for each button, considering the padding
          double buttonWidth =
              (constraints.maxWidth - 2 * 3.0) / _timerTypeTexts.length;

          return ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              viewModelProvider.onTogglePressed(index);
            },
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            selectedBorderColor: Theme.of(context).colorScheme.primary,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.primary,
            constraints: BoxConstraints(
              minHeight: 30.0,
              minWidth: buttonWidth,
            ),
            isSelected: viewModelState.toggleStates,
            children: _timerTypeTexts,
          );
        },
      ),
    );
  }
}
