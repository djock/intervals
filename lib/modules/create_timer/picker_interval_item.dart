import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:focus/utilities/constants.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../utilities/custom_style.dart';
import '../../utilities/picker_config.dart';
import '../../utilities/utils.dart';

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

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _currentIntValue = 0;
  int _maxIntValue = 0;
  bool _isInput = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _maxIntValue = widget.config.max;
    _currentIntValue = widget.value;
  }

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void onInputSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _currentIntValue = int.parse(_textController.text);

      if(_currentIntValue > _maxIntValue) {
        _maxIntValue = _currentIntValue;
      }

      _isInput = !_isInput;
      setState(() {});
    }
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
            GestureDetector(
              onLongPress: () {
                setState(() {
                  _isInput = !_isInput;
                });
              },
              child: _isInput ? _buildInput() : _buildPicker(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPicker() {
    return Container(
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
          maxValue: _maxIntValue,
          step: widget.config.step,
          haptics: true,
          onChanged: (value) => setState(() {
                widget.onChanged(value);
                _currentIntValue = value;
              })),
    );
  }

  Widget _buildInput() {
    return Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _textController,
          textAlign: TextAlign.center,
          onFieldSubmitted: (value) {
            onInputSubmit();
          },
          keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: false),
          autofocus: true,
          style: Theme.of(context).textTheme.headline6,
          decoration: CustomStyle.inputDecoration(context, ''),
          // validator: (value) {
          //
          //   if(value == null || value.isEmpty) {
          //     return 'Please enter a value';
          //   }
          //
          //   var intValue = int.tryParse(value);
          //
          //   if(intValue == null) {
          //     return 'Please enter a valid number';
          //   }
          //
          //   return null;
          // },
        ),
      ),
    );
  }
}
