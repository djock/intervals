import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/utilities/custom_style.dart';

class IntervalWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: CustomStyle.timerInputDecoration('Work'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: CustomStyle.timerInputDecoration('00:20'),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
