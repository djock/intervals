import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/pop_scope_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../modules/timers_list/timers_screen.dart';
import 'activities_screen.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  static const String id = 'NavigationScreen';

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends ConsumerState<NavigationScreen> {
  int _selectedScreenIndex = 0;
  List<Widget> _screens = [
    TimersScreen(),
    ActivitiesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScopeScreen(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(child: _screens[_selectedScreenIndex]),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
            showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                   AssetImage('assets/timers-icon.png') ,
                  size: 25,
                ),
              label: 'Timers'
            ),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.calendarDays),
                label: 'History'
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings),
            //   label: 'Settings',
            // ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedScreenIndex,
        ),
      ),
    );
  }

  void _onItemTapped(int selectedScreenIndex) {
    setState(() {
      _selectedScreenIndex = selectedScreenIndex;
    });
  }
}
