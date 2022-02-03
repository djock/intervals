import 'package:flutter/material.dart';
import 'package:focus/models/timer_settings.dart';

typedef void ChangeCallback(double);
typedef void NewTempoCallback(text, value);

TextStyle cardTitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.grey,
);

TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.w200,
  fontSize: 20,
  letterSpacing: 3,
  color: Colors.black,
);

Color buttonColor = Color(0xFFFAFAFA);
Color roundButtonIconColor = Colors.lightBlueAccent;
double roundButtonIconSize = 30.0;

TimerSettings activeTimerSettings = new TimerSettings();