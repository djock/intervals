import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/handlers/timer_handler.dart';
import 'package:focus/handlers/timers_manager.dart';
import 'package:focus/handlers/app_theme_handler.dart';

final isDarkThemeProvider = StateProvider<bool>((ref) => false);
final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeHandler());
final timersManagerProvider = ChangeNotifierProvider<TimersManager>((ref) => TimersManager());

final activeTimerProvider = ChangeNotifierProvider<ActiveTimer>((ref) => ActiveTimer());
