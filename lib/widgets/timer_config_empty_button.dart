import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:focus/widgets/round_button.dart';

class TimerConfigEmptyButton extends StatelessWidget {
  const TimerConfigEmptyButton({
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
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundButton(
                    height: roundButtonIconSize,
                    width: roundButtonIconSize,
                    color: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: buttonIconSize,
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
