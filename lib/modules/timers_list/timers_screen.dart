import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/modules/timers_list/add_grid_timer.dart';
import 'package:focus/modules/timers_list/grid_timer_item.dart';
import 'package:focus/screens/pop_scope_screen.dart';

import '../../providers/providers.dart';
import '../../utilities/localizations.dart';

class TimersScreen extends ConsumerWidget {
  static const String id = 'TimersScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  children: _buildTimers(ref, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTimers(WidgetRef ref, BuildContext context) {
    var timerManagerWatcher = ref.watch(timersManagerProvider);

    List<Widget> result = [];

    if (timerManagerWatcher.timers.length == 0) {
      result.add(Container(
          width: double.infinity,
          child: Center(child: Text(AppLocalizations.noTimers))));
    } else {
      for (var item in timerManagerWatcher.timers) {
        result.add(GridTimerItem(item));
      }
    }

    result.add(AddGridTimer());
    return result;
  }
}
