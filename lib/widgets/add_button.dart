import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final VoidCallback callback;

  const AddButton({Key? key, required this.callback})
      : super(key: key);

  @override
  AddButtonState createState() => AddButtonState();
}

class AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.callback,
      child: const Text('Add'),
    );
  }
}
