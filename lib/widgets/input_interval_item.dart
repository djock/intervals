import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

import '../utilities/localizations.dart';
import '../utilities/logger.dart';

class InputIntervalItem extends StatelessWidget {
  InputIntervalItem({
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ChangeCallback onChanged;

  void doNothing(BuildContext context) {
    logger.info('doNothing');
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintText: AppLocalizations.enterIntervalName,
                    hintStyle: Theme.of(context).textTheme.subtitle1,
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
                  controller: _valueController,
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
    );
  }
}
