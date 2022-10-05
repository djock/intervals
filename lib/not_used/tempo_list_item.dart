import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

class TempoListItem extends StatelessWidget {
  const TempoListItem({
    required this.value,
    required this.onChanged,
    required this.title,
    required this.color,
  });

  final int value;
  final ChangeCallback onChanged;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:  Border(
          bottom: BorderSide( //                   <--- left side
            color: Theme.of(context).colorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      child: Card(
        color: color,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                RoundButton(
                  height: roundButtonIconSize,
                  width: roundButtonIconSize,
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    value == 1 ? Icons.delete : Icons.remove,
                    color:  value == 1 ? Colors.red : Theme.of(context).colorScheme.onPrimary,
                    size: roundButtonIconSize,
                  ),
                  onPressed: () {
                    onChanged(value - 1);
                  },
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                RoundButton(
                  height: roundButtonIconSize,
                  width: roundButtonIconSize,
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: roundButtonIconSize,
                  ),
                  onPressed: () {
                    onChanged(value + 1);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
