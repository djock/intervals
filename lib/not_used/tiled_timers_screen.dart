import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus/models/timer_tile_style.dart';
import 'package:focus/screens/pop_scope_screen.dart';
import 'package:focus/not_used/timer_tile_item.dart';

import '../providers/providers.dart';
import '../utilities/localizations.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/expandable_timer_list_item.dart';
import 'timer_list_item_tile.dart';
import '../screens/create_timer_screen.dart';

class TiledTimersScreen extends ConsumerWidget {
  static const String id = 'TiledTimersScreen';

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
              ref.watch(timersManagerProvider).timers.length == 0 ?
              Container(
                width: double.infinity,
                height: 100,

                child: Center(
                  child: Text(AppLocalizations.noTimers),
                ),
              ) :
              Expanded(
                child:
                SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
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

    for (var item in timerManagerWatcher.timers) {
      result.add(TimerTileItem(item));
    }

    return result;
  }
}
