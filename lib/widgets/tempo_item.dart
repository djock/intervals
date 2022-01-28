import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

class TempoItem extends StatelessWidget {
  const TempoItem({
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
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: kCardTitleTextStyle,
                  ),
                ],
              ),
            ),
            RoundButton(
              color: kSettingsButtonColor,
              child: Icon(
                Icons.remove,
                color: kSettingsButtonIconColor,
                size: kSettingsButtonIconSize,
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
                fontSize: 45,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            RoundButton(
              color: kSettingsButtonColor,
              child: Icon(
                Icons.add,
                color: kSettingsButtonIconColor,
                size: kSettingsButtonIconSize,
              ),
              onPressed: () {
                onChanged(value + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
