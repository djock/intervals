import 'package:flutter/material.dart';

import 'localizations.dart';

class CustomStyle {
  static OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.0),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Colors.red),
    borderRadius: BorderRadius.circular(10.0),
  );

  static InputDecoration inputDecoration(BuildContext context) =>
      InputDecoration(
        isDense: true,
          hintText: AppLocalizations.addNameHere,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).hintColor),
          filled: true,
          contentPadding: EdgeInsets.all(10.0),
          errorStyle: TextStyle(height: 0),
          fillColor: Theme.of(context).colorScheme.secondary,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          errorBorder: errorBorder,
          disabledBorder: inputBorder,
          border: inputBorder);
}
