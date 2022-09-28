import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus/utilities/constants.dart';
import 'package:numberpicker/numberpicker.dart';

import '../utilities/logger.dart';

class PickerIntervalItem extends ConsumerStatefulWidget {
  PickerIntervalItem({
    required this.value,
    required this.onChanged,
    required this.title,
  });

  final int value;
  final ChangeCallback onChanged;
  final String title;

  @override
  PickerIntervalItemState createState() => PickerIntervalItemState();
}

class PickerIntervalItemState extends ConsumerState<PickerIntervalItem> {
  void doNothing(BuildContext context) {
    logger.info('doNothing');
  }

  final TextEditingController _textEditingController = TextEditingController();

  int _currentIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            icon: Icons.delete,
          ),
        ],
      ),
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
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              width: 120,
              child: NumberPicker(
                  axis: Axis.horizontal,
                  textStyle: Theme.of(context).textTheme.bodyText2,
                  selectedTextStyle: Theme.of(context).textTheme.headline6,
                  itemWidth: 40,
                  value: _currentIntValue,
                  minValue: 0,
                  maxValue: 300,
                  step: 5,
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
