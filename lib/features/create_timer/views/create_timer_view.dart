import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/view_models/timer_type_selector_view_model.dart';
import 'package:focus/features/create_timer/views/interval_widget.dart';
import 'package:focus/features/create_timer/views/timer_icon_title_widget.dart';
import 'package:focus/features/create_timer/views/timer_type_selector_widget.dart';
import 'package:focus/modules/create_timer/picker_interval_item.dart';
import 'package:focus/modules/create_timer/edit_interval_bottom_sheet.dart';
import 'package:focus/modules/create_timer/slider_interval_item.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/picker_config.dart';
import 'package:focus/providers/providers.dart';
import 'package:focus/modules/create_timer/add_interval_bottom_sheet.dart';
import 'package:focus/modules/create_timer/row_text_icon_button.dart';

class CreateTimerView extends ConsumerStatefulWidget {
  static const String id = 'CreateTimerScreen';

  @override
  CreateTimerViewState createState() => CreateTimerViewState();
}

class CreateTimerViewState extends ConsumerState<CreateTimerView> {
  @override
  Widget build(BuildContext context) {
    final timerTypeSelectorViewModelState =
        ref.watch(timerTypeSelectorViewModelProvider);

    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
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
                  SizedBox(
                    height: 5,
                  ),
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
                  TimerTypeSelectorWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  IntervalWidget(),
                  RowIconTextButton(
                    callback: () {
                    },
                    text: AppLocalizations.addInterval,
                    icon: Icons.add,
                  ),
                ],
              )),
            )),
          ],
        ),
      ),
    );
  }
}
