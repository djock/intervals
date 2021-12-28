import 'package:flutter/material.dart';
import 'package:focus/screens/configuration_screen.dart';
import 'package:focus/screens/tempo_screen.dart';
import 'package:provider/provider.dart';
import 'package:focus/state/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Settings>(
      create: (context)=> Settings(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ConfigurationScreen.id,
        routes: {
          ConfigurationScreen.id: (context) => ConfigurationScreen(),
          TempoScreen.id: (context) => TempoScreen(),
        },
      ),
    );
  }
}
