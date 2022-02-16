import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

class TempoListItem extends StatelessWidget {
  const TempoListItem({
    required this.value,
    required this.onChanged,
    required this.title,
  });

  final int value;
  final ChangeCallback onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    style: Theme.of(context).textTheme.bodyText2,
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
