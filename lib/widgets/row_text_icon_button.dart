import 'package:flutter/material.dart';

class RowIconTextButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final MainAxisAlignment axisAlignment;
  final IconData icon;

  const RowIconTextButton(
      {Key? key,
      required this.callback,
      required this.text,
      required this.icon,
      this.axisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
