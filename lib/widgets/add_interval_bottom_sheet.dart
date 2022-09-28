import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/widgets/input_interval_item.dart';

import 'expanded_test_button.dart';

class AddIntervalBottomSheet extends StatefulWidget {
  final NewTempoCallback callback;

  const AddIntervalBottomSheet({Key? key, required this.callback})
      : super(key: key);

  @override
  AddIntervalBottomSheetState createState() => AddIntervalBottomSheetState();
}

class AddIntervalBottomSheetState extends State<AddIntervalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          InputIntervalItem(
            value: _duration,
            onChanged: (newValue) {
              _duration = newValue;
              setState(() {});
            },
          ),
          ExpandedTextButton(
              text: AppLocalizations.addTempo,
              callback: () {
                if (_formKey.currentState!.validate()) {
                  widget.callback(_textFieldController.text, _duration);
                }
              }),
        ],
      ),
    );
  }

  Widget _entryField(String defaultText) {
    return Center(
      child: TextFormField(
        controller: _textFieldController,
        keyboardType: TextInputType.text,
        validator: (value) {
          bool fieldValid = value!.length > 1 && value != "0";

          if (!fieldValid) {
            return 'error';
          }
          return null;
        },
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontStyle: FontStyle.italic,
            ),
            errorBorder: new OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.7),
                  width: 2),
              borderRadius: const BorderRadius.all(
                const Radius.circular(5),
              ),
            ),
            border: new OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 2),
              borderRadius: const BorderRadius.all(
                const Radius.circular(5),
              ),
            ),
            hintText: defaultText,
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            hintStyle: Theme.of(context).textTheme.subtitle2),
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
