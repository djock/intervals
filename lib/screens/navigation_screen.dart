import 'package:flutter/material.dart';
import 'package:focus/screens/timer_settings_screen.dart';

class NavigationScreen extends StatefulWidget {
  static const String id = 'NavigationScreen';

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen> {
  int _selectedScreenIndex = 0;
  List<Widget> _screens = [
    TimerSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(

        body: Container(padding: EdgeInsets.all(10),child: _screens[_selectedScreenIndex]),
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
