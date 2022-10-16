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
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              value,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).hintColor),
            ),
          ],
        ),
      ),
    );
  }

}

