import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/utilities/picker_config.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../providers/providers.dart';
import '../../utilities/custom_style.dart';
import '../../widgets/expanded_test_button.dart';

class EditIntervalBottomSheet extends ConsumerStatefulWidget {
  final String title;
  final int value;
  final int index;

  EditIntervalBottomSheet(this.title, this.value, this.index);

  @override
  EditIntervalBottomSheetState createState() => EditIntervalBottomSheetState();
}

class EditIntervalBottomSheetState extends ConsumerState<EditIntervalBottomSheet> {
  String _intervalName = '';

  int _duration = 5;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _duration = widget.value;
    _intervalName = widget.title;

    super.initState();
  }

  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activeTimerWatcher = ref.watch(activeTimerProvider);

    var config = PickerConfig.interval;
    _nameController.value = TextEditingValue(text: widget.title);

    _nameController.addListener(() {
      _intervalName = _nameController.text;
    });

    return Container(
      height: 150,
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: CustomStyle.inputDecoration(context, ''),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: 120,
                  child: NumberPicker(
                      axis: Axis.horizontal,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Theme.of(context).hintColor),
                      selectedTextStyle: Theme.of(context).textTheme.titleLarge,
                      itemWidth: 40,
                      value: _duration,
                      minValue: config.min,
                      maxValue: config.max,
                      step: config.step,
                      haptics: true,
                      onChanged: (value) => setState(() {
                        _duration = value;
                      })),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          ExpandedTextButton(
              text: AppLocalizations.saveInterval,
              callback: () {
                activeTimerWatcher.updateInterval(widget.index, _intervalName, _duration);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

}
