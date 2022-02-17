import 'package:flutter/material.dart';
import 'package:focus/utilities/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class RestConfigButton extends StatefulWidget {
  const RestConfigButton({
    required this.value,
    required this.onChanged,
    required this.title,
  });

  final int value;
  final ChangeCallback onChanged;
  final String title;

  @override
  RestConfigButtonState createState() => RestConfigButtonState();
}

class RestConfigButtonState extends State<RestConfigButton> {
  int _currentIntValue = 10;

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
                widget.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            NumberPicker(
              axis: Axis.horizontal,
              textStyle: Theme.of(context).textTheme.bodyText2,
              selectedTextStyle: Theme.of(context).textTheme.headline6,
              itemWidth: 35,
              value: _currentIntValue,
              minValue: 0,
              maxValue: 300,
              step: 5,
              haptics: true,
              onChanged: (value) => setState(() {
                widget.onChanged(value);
                _currentIntValue = value;
              })),
            ],
          ),
        ),
      ),
    );
  }
}
