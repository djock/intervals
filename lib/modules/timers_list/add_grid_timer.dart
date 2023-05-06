import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/features/create_timer/views/create_timer_view.dart';

import '../../providers/providers.dart';

class AddGridTimer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return GestureDetector(
      onTap: () {
        final activeTimerWatcher = ref.watch(activeTimerProvider);
        activeTimerWatcher.clear();

        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return CreateTimerView();
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10, left: 10, top: 5, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text("+",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 60, fontWeight: FontWeight.w100)),
              )
            ),
          ],
        ),
      ),
    );
  }
}