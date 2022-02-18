import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/utilities/localizations.dart';
import 'package:focus/widgets/tempo_list_item.dart';

import 'expanded_test_button.dart';

class CreateTempoWidget extends StatefulWidget {
  final NewTempoCallback callback;

  const CreateTempoWidget({Key? key, required this.callback}) : super(key: key);

  @override
  CreateTempoWidgetState createState() => CreateTempoWidgetState();
}

class CreateTempoWidgetState extends State<CreateTempoWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Theme.of(context).colorScheme.secondary,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Form(
                key: _formKey,
                child: _entryField(AppLocalizations.tempoNamePlaceholder, _textFieldController)),
          ),
          TempoListItem(
            color: Colors.transparent,
              value: _duration,
              onChanged: (newValue) {
                _duration = newValue;
                setState(() {});
              },
              title: AppLocalizations.durationInSeconds),
          ExpandedTextButton(text: AppLocalizations.addTempo,
              callback: () {
                if(_formKey.currentState!.validate()) {
                  widget.callback(_textFieldController.text, _duration);
                }
              }),
        ],
      ),
    );
  }

  Widget _entryField(String defaultText, TextEditingController controller) {
    return Center(
      child: TextFormField(
        controller: controller,
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
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.error.withOpacity(0.7), width: 2),
              borderRadius: const BorderRadius.all(
                const Radius.circular(5),
              ),
            ),
            border: new OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary, width: 2),
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
