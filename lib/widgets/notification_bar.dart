import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationBar {
  static Flushbar build(BuildContext context, String title, String message, Color color) =>
      Flushbar(
        animationDuration: Duration(milliseconds: 500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: color,
        isDismissible: true,
        title: title,
        titleColor: Theme.of(context).colorScheme.onError,
        margin: EdgeInsets.all(10),
        message: message,
        duration: Duration(seconds: 5),
        borderRadius: BorderRadius.circular(8),
      )..show(context);
}