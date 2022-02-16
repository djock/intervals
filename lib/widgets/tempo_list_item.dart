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
                    style: cardTitleTextStyle,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                RoundButton(
                  height: 35,
                  width: 35,
                  color: Colors.white,
                  child: Icon(
                    Icons.remove,
                    color: roundButtonIconColor,
                    size: roundButtonIconSize,
                  ),
                  onPressed: () {
                    if (value > 1) {
                      onChanged(value - 1);
                    }
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
                  height: 35,
                  width: 35,
                  color: Colors.white,
                  child: Icon(
                    Icons.add,
                    color: roundButtonIconColor,
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
