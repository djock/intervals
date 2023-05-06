import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/view_models/create_timer_view_model.dart';
import 'package:focus/features/create_timer/view_models/timer_type_selector_view_model.dart';
import 'package:focus/main.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:focus/utilities/custom_style.dart';
import 'package:focus/utilities/localizations.dart';

class TimerTypeSelectorWidget extends ConsumerWidget {
  final List<Widget> _timerTypeTexts = <Widget>[
    Text(AppLocalizations.forReps),
    Text(AppLocalizations.forTime),
  ];

  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider =
        ref.watch(timerTypeSelectorViewModelProvider.notifier);
    final viewModelState = ref.watch(timerTypeSelectorViewModelProvider);

    final createTimerViewModel = ref.watch(createTimerViewModelProvider);

    return Column(
      children: [
        Container(
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
        ),
        viewModelState.selectedTimerType == TimerType.reps
            ? Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Sets input
                    Expanded(
                      child: Container(
                        child: TextField(
                          decoration: CustomStyle.timerInputDecoration(
                              AppLocalizations.sets),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            // Handle sets input value
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text('X', style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(width: 10.0),
                    // Reps input
                    Expanded(
                      child: TextField(
                        decoration: CustomStyle.timerInputDecoration(
                            AppLocalizations.reps),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Handle reps input value
                        },
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text('/', style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(width: 10.0),
                    // Rest input
                    Expanded(
                      child: TextField(
                        decoration: CustomStyle.timerInputDecoration(
                            AppLocalizations.rest),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Handle rest input value
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 50,
                color: Colors.red,
              )
      ],
    );
  }
}
