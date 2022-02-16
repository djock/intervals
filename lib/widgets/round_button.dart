import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({required this.child, required this.onPressed, required this.color, this.height = 55.0, this.width = 55.0});

  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.all(0),
      minWidth: width,
      child: MaterialButton(
        elevation: 0,
        color: color,
        onPressed: onPressed,
        onLongPress: onPressed,
        child: child,
        shape: CircleBorder(),
        height: height,
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
