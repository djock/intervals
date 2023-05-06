import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../utilities/utils.dart';

class SliderIntervalItem extends ConsumerStatefulWidget {
  final int value;
  final String title;
  final Function onEdit;
  final Function onDelete;

  SliderIntervalItem(this.value, this.title, this.onEdit, this.onDelete);

  @override
  SliderIntervalItemState createState() => SliderIntervalItemState();
}

class SliderIntervalItemState extends ConsumerState<SliderIntervalItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 4,
            onPressed: (context) => widget.onDelete(),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            icon: Icons.delete,
          ),
          SlidableAction(
            flex: 4,
            onPressed: (context) => widget.onEdit(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.edit,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // border: Border(
          //   bottom: BorderSide(
          //     color: Theme.of(context).colorScheme.secondary,
          //     width: 0.8,
          //   ),
          // )
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              Utils.formatTime(widget.value),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
