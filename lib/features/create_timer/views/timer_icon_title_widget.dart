import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/view_models/create_timer_view_model.dart';
import 'package:focus/models/timer_type_enum.dart';
import 'package:focus/utilities/custom_style.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimerIconTitleWidget extends ConsumerWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(createTimerViewModelProvider.notifier);
    final viewModelState = ref.watch(createTimerViewModelProvider);

    if(viewModelState.timerModel!.name != null && viewModelState.timerModel!.name!.isNotEmpty) {
      _textEditingController.text = viewModelState.timerModel!.name!;
      _textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: _textEditingController.text.length));
    }

    return Row(
      children: [
        Container(
            alignment: Alignment.center,
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              viewModelState.timerModel!.type == TimerType.reps
                  ? FontAwesomeIcons.dumbbell
                  : FontAwesomeIcons.clock,
              color: Theme.of(context).primaryColor,
            )),
        SizedBox(width: 20.0),
        Expanded(
          child: TextField(
            controller: _textEditingController,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: CustomStyle.inputDecoration(
                context, AppLocalizations.timerName),
            onChanged: (value) {
              viewModelProvider.setTimerName(value);
            },
          ),
        )
      ],
    );
  }

}