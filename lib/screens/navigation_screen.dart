import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/pop_scope_screen.dart';

import '../modules/timers_list/timers_screen.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  static const String id = 'NavigationScreen';

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends ConsumerState<NavigationScreen> {
  int _selectedScreenIndex = 0;
  List<Widget> _screens = [
    TimersScreen(),
    // CreateTimerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(child: _screens[_selectedScreenIndex]),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.timer),
        //         label: 'Settings'
        //     ),
        //     // BottomNavigationBarItem(
        //     //     icon: Icon(Icons.ac_unit_rounded),
        //     //     label: 'Settings'
        //     // ),
        //     // BottomNavigationBarItem(
        //     //   icon: Icon(Icons.settings),
        //     //   label: 'Settings',
        //     // ),
        //   ],
        //   onTap: _onItemTapped,
        //   currentIndex: _selectedScreenIndex,
        // ),
      ),
    );
  }

  // void _onItemTapped(int selectedScreenIndex) {
  //   debugPrint('tap ' + selectedScreenIndex.toString());
  //   setState(() {
  //     _selectedScreenIndex = selectedScreenIndex;
  //   });
  // }
}
