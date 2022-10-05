import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/pop_scope_screen.dart';

import '../providers/providers.dart';
import '../utilities/localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/expandable_timer_list_item.dart';
import 'create_timer_screen.dart';

class TimersScreen extends ConsumerWidget {
  static const String id = 'TimersScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.buildWithAction(
            context, AppLocalizations.timersScreenTitle, [
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(CreateTimerScreen.id);
              })
        ]),
        body: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildTimers(ref),
                  ),
                ),
              ),
              // ExpandedTextButton(
              //     text: AppLocalizations.createTimer,
              //     callback: () {
              //       Navigator.of(context).pushNamed(CreateTimerScreen.id);
              //     })
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTimers(WidgetRef ref) {
    var timerManagerWatcher = ref.watch(timersManagerProvider);

    List<Widget> result = [];

    if (timerManagerWatcher.timers.length == 0) {
      result.add(Container(width: double.infinity, child: Center(child: Text(AppLocalizations.noTimers))));
    } else {
      for (var item in timerManagerWatcher.timers) {
        result.add(ExpandableTimerListItem(item));
        result.add(SizedBox(
          height: 10,
        ));
      }
    }

    return result;
  }
}
