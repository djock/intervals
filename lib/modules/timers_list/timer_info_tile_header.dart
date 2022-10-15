import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimerInfoTileHeader extends ConsumerWidget {
  final String title;
  final Color color;
  final IconData icon;
  final Function onTap;

  TimerInfoTileHeader({required this.title, required this.color, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: color),
          ),
          Container(
            width: 15,
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () => onTap(),
              icon: FaIcon(
                icon,
                color: color,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

}