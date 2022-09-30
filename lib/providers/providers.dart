import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/models/timer_settings.dart';
import 'package:focus/utilities/app_theme_state.dart';

final isDarkThemeProvider = StateProvider<bool>((ref) => false);
final timerSettingsNotifier = ChangeNotifierProvider<TimerSettings>((ref) => TimerSettings());
final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());
