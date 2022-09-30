import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/create_timer_screen.dart';
import 'package:focus/screens/navigation_screen.dart';
import 'package:focus/screens/timer_screen.dart';
import 'package:focus/utilities/app_theme.dart';
import 'package:focus/providers/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future.delayed(Duration(milliseconds: 1))
      .then((value) => SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]));

  runApp(
      ProviderScope(
    child: App(),
  ));
}

class App extends StatefulWidget {
  static const String id = 'TimerSettingsScreen';

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final appThemeState = ref.watch(appThemeStateNotifier);
        appThemeState.setOverlayStyle();

        return MaterialApp(
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          initialRoute: NavigationScreen.id,
          routes: {
            NavigationScreen.id: (context) => NavigationScreen(),
            TimerScreen.id: (context) => TimerScreen(),
            CreateTimerScreen.id: (context) => CreateTimerScreen(),
          },
        );
      },
    );
  }
}