import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

class TimerConfigButton extends StatelessWidget {
  const TimerConfigButton({
    required this.value,
    required this.onChanged,
    required this.title,
  });

  final int value;
  final ChangeCallback onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: cardTitleTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                    height: roundButtonIconSize,
                    width: roundButtonIconSize,
                    color: Colors.white,
                    child: Icon(
                      value == 1 ? Icons.delete : Icons.remove,
                      color: value == 1 ? Colors.red : roundButtonIconColor,
                      size: buttonIconSize,
                    ),
                    onPressed: () {
                        onChanged(value - 1);
                    },
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  RoundButton(
                    height: 15,
                    width: 15,
                    color: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: roundButtonIconColor,
                      size: 20,
                    ),
                    onPressed: () {
                      onChanged(value + 1);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
