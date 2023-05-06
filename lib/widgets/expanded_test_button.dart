import 'package:flutter/material.dart';

class ExpandedTextButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const ExpandedTextButton(
      {Key? key, required this.text, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                minimumSize: Size(250, 50),
                side: BorderSide.none,
                backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: callback,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
            ),
          )),
        ],
      ),
    );
  }
}
