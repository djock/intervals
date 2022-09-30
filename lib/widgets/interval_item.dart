import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

import '../utilities/utils.dart';

class IntervalItem extends StatelessWidget {
  IntervalItem({
    required this.value,
    required this.onChanged,
    required this.title,
    required this.canSlide,
  });

  final int value;
  final ChangeCallback onChanged;
  final String title;
  final bool canSlide;

  void doNothing(BuildContext context) {
    log.info('doNothing');
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

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
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(
              children: [
                RoundButton(
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    value == 1 ? Icons.delete : Icons.remove,
                    color: value == 1
                        ? Colors.red
                        : Theme.of(context).colorScheme.onPrimary,
                    size: roundButtonIconSize,
                  ),
                  onPressed: () {
                    onChanged(value - 1);
                  },
                ),
                Container(
                  width: 60,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.headline6,
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: value.toString(),
                        hintStyle: Theme.of(context).textTheme.headline6,
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 0.2,
                                color:
                                    Theme.of(context).colorScheme.secondary))),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.toString() == '0') {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                RoundButton(
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: roundButtonIconSize,
                  ),
                  onPressed: () {
                    onChanged(value + 1);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
