import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focus/utilities/providers.dart';

class ConfigurationScreen extends ConsumerWidget {
  static const String id = 'ConfigurationScreen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkThemeProvider);

    return WillPopScope(
      onWillPop: ()  async { return true; },
      child: Scaffold(
          appBar: AppBar(title: Text('tempo App'),),
          body: Center(child: Text('test'),))
    );
  }
}
