import 'package:flutter/material.dart';

class TimerStatWidget extends StatelessWidget {
  const TimerStatWidget({
    required this.value,
    required this.title,
  });

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.button,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
