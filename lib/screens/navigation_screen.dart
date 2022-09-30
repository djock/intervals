import 'package:flutter/material.dart';

import 'create_timer_screen.dart';

class NavigationScreen extends StatefulWidget {
  static const String id = 'NavigationScreen';

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  int _selectedScreenIndex = 0;
  List<Widget> _screens = [
    CreateTimerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(padding: EdgeInsets.all(20),child: _screens[_selectedScreenIndex]),
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
