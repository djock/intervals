import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/screens/create_timer_screen.dart';
import 'package:focus/screens/navigation_screen.dart';
import 'package:focus/not_used/tiled_timers_screen.dart';
import 'package:focus/screens/timer_screen.dart';
import 'package:focus/screens/timers_screen.dart';
import 'package:focus/utilities/app_theme.dart';
import 'package:focus/providers/providers.dart';

import 'handlers/hive_handler.dart';

void main() {
  HiveHandler.init();

  WidgetsFlutterBinding.ensureInitialized();

  Future.delayed(Duration(milliseconds: 1))
      .then((value) => SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]));

  runApp(ProviderScope(
    child: App(),
  ));
}

class App extends ConsumerStatefulWidget {
  static const String id = 'TimerSettingsScreen';

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    appThemeState.setOverlayStyle();

    var timersManagerWatcher = ref.read(timersManagerProvider);
    timersManagerWatcher.getHiveTimers();

    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      initialRoute: NavigationScreen.id,
      routes: {
        NavigationScreen.id: (context) => NavigationScreen(),
        TimerScreen.id: (context) => TimerScreen(),
        CreateTimerScreen.id: (context) => CreateTimerScreen(),
        TimersScreen.id: (context) => TimersScreen(),
        TiledTimersScreen.id: (context) => TiledTimersScreen(),
      },
    );
  }
}
