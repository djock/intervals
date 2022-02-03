import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/models/timer_settings.dart';

final isDarkThemeProvider = StateProvider<bool>((ref) => false);
final timerSettingsNotifier = ChangeNotifierProvider<TimerSettings>((ref) => TimerSettings());

