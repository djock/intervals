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
              style: Theme.of(context).textTheme.headline4,
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


  // Widget _bult() {
  //   return Card(
  //     color: Theme.of(context).colorScheme.secondary,
  //     elevation: 0,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
  //       child: ,
  //     ),
  //   );
  // }

}

