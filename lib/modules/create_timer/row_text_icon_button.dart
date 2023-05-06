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
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
          ),
          text.isNotEmpty ?
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ) : SizedBox()
        ],
      ),
    );
  }
}
