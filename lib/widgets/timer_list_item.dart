import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/timer_model.dart';
import '../providers/providers.dart';
import '../screens/timer_screen.dart';

class TimerListItem extends ConsumerWidget {
  final TimerModel timer;

  TimerListItem(this.timer);
  @override
  Widget build(BuildContext context, WidgetRef ref  ) {
    return GestureDetector(
      onTap: () {
        var activeTimerWatcher = ref.watch(activeTimerProvider);
        activeTimerWatcher.setTimer(timer);

        Navigator.of(context).pushNamed(TimerScreen.id);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(timer.name),
                  Text(timer.sets.toString() + 'x' + timer.reps.toString() + ' rest ' + timer.rest.toString() + 's', style: Theme.of(context).textTheme.bodyText1,),
                ],
            ),
          ],
        ),
        // child: ExpansionTile(
        //   title: Text(timer.name),
        //   subtitle: Text(timer.sets.toString() + 'x' + timer.reps.toString() + ' rest ' + timer.rest.toString() + 's', style: Theme.of(context).textTheme.bodyText1,),
        //   // children: <Widget>[
        //   //   // ListTile(title: Text('here details')),
        //   // ],
        // ),
      ),
    );
  }
}
