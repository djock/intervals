import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/modules/active_timer/timer_end_screen.dart';
import 'package:focus/screens/navigation_screen.dart';
import 'package:focus/modules/active_timer/timer_screen.dart';
import 'package:focus/models/app_theme_model.dart';
import 'package:focus/providers/providers.dart';

import 'handlers/hive_handler.dart';
import 'modules/create_timer/create_timer_screen.dart';
import 'modules/create_timer/edit_timer_screen.dart';
import 'modules/timers_list/timers_screen.dart';

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
      theme: AppThemeModel.lightTheme,
      darkTheme: AppThemeModel.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      initialRoute: NavigationScreen.id,
      routes: {
        NavigationScreen.id: (context) => NavigationScreen(),
        TimerScreen.id: (context) => TimerScreen(),
        CreateTimerScreen.id: (context) => CreateTimerScreen(),
        TimersScreen.id: (context) => TimersScreen(),
        EditTimerScreen.id: (context) => EditTimerScreen(),
        TimerEndScreen.id: (context) => TimerEndScreen(),
      },
    );
  }
}
