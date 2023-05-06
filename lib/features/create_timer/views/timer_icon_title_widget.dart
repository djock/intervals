import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/view_models/create_timer_view_model.dart';
import 'package:focus/features/create_timer/views/timer_icon_widget.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/custom_style.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:focus/features/create_timer/view_models/timer_icon_view_model.dart';

class TimerIconTitleWidget extends ConsumerWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(createTimerViewModelProvider.notifier);
    final viewModelState = ref.watch(createTimerViewModelProvider);

    final timerIconProvider = ref.watch(timerIconViewModelProvider.notifier);
    final timerIconState = ref.watch(timerIconViewModelProvider);

    if (viewModelState.timerModel!.name != null &&
        viewModelState.timerModel!.name!.isNotEmpty) {
      _textEditingController.text = viewModelState.timerModel!.name!;
      _textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController.text.length));
    }

    void selectIcon(int index) {
      timerIconProvider.setShowIconSelector(false);
      viewModelProvider.setTimerIcon(index);
    }

    void cancelIconSelection() {
      timerIconProvider.setShowIconSelector(false);
    }

    return Row(
      children: [
        timerIconState.showIconSelector
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TimerIconWidget(onTap: () => selectIcon(0), iconIndex: 0),
                      SizedBox(width: 5.0),
                      TimerIconWidget(onTap: () => selectIcon(1), iconIndex: 1),
                      SizedBox(width: 5.0),
                      TimerIconWidget(onTap: () => selectIcon(2), iconIndex: 2),
                      SizedBox(width: 5.0),
                      TimerIconWidget(onTap: () => selectIcon(3), iconIndex: 3),
                      SizedBox(width: 5.0),
                      TimerIconWidget(onTap: () => selectIcon(4), iconIndex: 4),
                      SizedBox(width: 5.0),
                    ],
                  ),
                  IconButton(
                      onPressed: () => cancelIconSelection(),
                      icon: Icon(
                        FontAwesomeIcons.xmark,
                        color: Theme.of(context).colorScheme.error,
                      )),
                ],
              )
            : GestureDetector(
                onTap: () {
                  timerIconProvider.setShowIconSelector(true);
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      timerIcons[viewModelState.timerModel!.iconIndex],
                      color: Theme.of(context).primaryColor,
                    )),
              ),
        SizedBox(width: 20.0),
        timerIconState.showIconSelector
            ? SizedBox()
            : Expanded(
                child: TextField(
                  controller: _textEditingController,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: CustomStyle.inputDecoration(
                      context, AppLocalizations.timerName),
                  onChanged: (value) {
                    viewModelProvider.setTimerName(value);
                  },
                  onTap: () {
                    if (timerIconState.showIconSelector) {
                      timerIconProvider.setShowIconSelector(false);
                    }
                    print('test');
                  },
                ),
              )
      ],
    );
  }
}
