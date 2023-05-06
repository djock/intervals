import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimerIconWidget extends ConsumerWidget {
  final Function onTap;
  final int iconIndex;

  TimerIconWidget({required this.onTap, required this.iconIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
          alignment: Alignment.center,
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          child: FaIcon(
            timerIcons[iconIndex],
            color: Theme.of(context).primaryColor,
          )),
    );
  }
}
