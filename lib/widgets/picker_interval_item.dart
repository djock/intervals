import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus/utilities/constants.dart';
import 'package:numberpicker/numberpicker.dart';

import '../utilities/picker_config.dart';
import '../utilities/utils.dart';

class PickerIntervalItem extends ConsumerStatefulWidget {
  PickerIntervalItem(
      {required this.value,
      required this.onChanged,
      required this.title,
      required this.config,
      required this.canSlide});

  final int value;
  final ChangeCallback onChanged;
  final String title;
  final PickerConfig config;
  final bool canSlide;

  @override
  PickerIntervalItemState createState() => PickerIntervalItemState();
}

class PickerIntervalItemState extends ConsumerState<PickerIntervalItem> {
  void doNothing(BuildContext context) {
    log.info('doNothing');
  }

  int _currentIntValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _currentIntValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: widget.canSlide
          ? ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: doNothing,
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  icon: Icons.delete,
                ),
              ],
            )
          : null,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline6,
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
                      .bodyText1!
                      .copyWith(color: Theme.of(context).hintColor),
                  selectedTextStyle: Theme.of(context).textTheme.headline6,
                  itemWidth: 40,
                  value: _currentIntValue,
                  minValue: widget.config.min,
                  maxValue: widget.config.max,
                  step: widget.config.step,
                  haptics: true,
                  onChanged: (value) => setState(() {
                        widget.onChanged(value);
                        _currentIntValue = value;
                      })),
            )
          ],
        ),
      ),
    );
  }
}
