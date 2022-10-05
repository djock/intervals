import 'package:flutter/material.dart';

class TimerTileStyle {
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;

  TimerTileStyle(this.backgroundColor, this.textColor, this.padding);
}

class TimerTileStyleConfig {
  static TimerTileStyle dark(BuildContext context) {
    return new TimerTileStyle(Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.onPrimary, EdgeInsets.all(0));
  }

  static TimerTileStyle light(BuildContext context) {
    return new TimerTileStyle(Theme.of(context).canvasColor, Theme.of(context).primaryColor, EdgeInsets.all(0));
  }
}