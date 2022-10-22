import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/pop_scope_screen.dart';

import '../../providers/providers.dart';
import '../../utilities/localizations.dart';
import '../../widgets/custom_app_bar.dart';
import '../modules/timers_list/expandable_timer_list_item.dart';

class ActivitiesScreen extends ConsumerWidget {
  static const String id = 'ActivitiesScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.buildNormal(
            context, AppLocalizations.activities),
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
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTimers(WidgetRef ref) {
    var timerManagerWatcher = ref.watch(timersManagerProvider);

    List<Widget> result = [];

    if (timerManagerWatcher.activities.length == 0) {
      result.add(Container(width: double.infinity, child: Center(child: Text(AppLocalizations.noActivities))));
    } else {
      for (var item in timerManagerWatcher.activities) {
        result.add(ExpandableTimerListItem(item));
        result.add(SizedBox(
          height: 10,
        ));
      }
    }

    return result;
  }
}
