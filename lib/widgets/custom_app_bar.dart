import 'package:flutter/material.dart';

class CustomAppBar {
  static PreferredSizeWidget buildWithActions(List<Widget> actions,
      {double elevation = 0.0, String text = '', double iconSize = 24}) {
    return AppBar(
      elevation: elevation,
      iconTheme: IconThemeData(color: Colors.teal, size: iconSize),
      actions: actions,
      title: Text(
        text.toUpperCase(),
      ),
      centerTitle: true,
    );
  }

  static PreferredSizeWidget buildNormal(BuildContext context, String text,
      {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: elevation,
        title: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildWithAction(BuildContext context, String text, List<Widget> actions,
      {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        leading: SizedBox(),
        actions: actions,
        title: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      );
}