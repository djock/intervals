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
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildWithAction(
          BuildContext context, String text, List<Widget> actions,
          {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        leading: SizedBox(),
        actions: actions,
        title: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildWithActionAndGoBack(
          BuildContext context, String text, List<Widget> actions,
          {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        actions: actions,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      );

  static PreferredSizeWidget buildWithActionAndGoBackClear(BuildContext context,
          String text, List<Widget> actions, Function onPressed,
          {double elevation = 0.0}) =>
      AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: elevation,
        actions: actions,
        leading: BackButton(
          onPressed: () => onPressed(),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      );
}
