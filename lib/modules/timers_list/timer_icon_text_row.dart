import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimerIconTextRow extends ConsumerWidget {
  final String title;
  final IconData icon;

  TimerIconTextRow(this.title, this.icon);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          width: 20,
          child: Center(
            child: FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 22,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }
}