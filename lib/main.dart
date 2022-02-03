import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/timer_settings_screen.dart';

void main() {
  Future.delayed(Duration(milliseconds: 1)).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xFFF1F2F6),
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Color(0xFFF1F2F6),
          )));
  Future.delayed(Duration(milliseconds: 1))
      .then((value) => SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]));

  runApp(ProviderScope(
    child: MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      initialRoute: TimerSettingsScreen.id,
      routes: {
        TimerSettingsScreen.id: (context) => TimerSettingsScreen(),
      },
    ),
  ));
}
