import 'package:flutter/material.dart';

/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
///
class AppTheme {
  // Private Constructor
  AppTheme._();
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    primaryColor: new Color(0XFF4D358B),
    primaryColorDark: Colors.black,
    hintColor: new Color(0XFFBBBBBB),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: new Color(0XFF4D358B),
      onPrimary: Colors.white,
      secondary: new Color(0XFFf2f2f2),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: new Color(0XFF4D358B),
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        bodySmall: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        titleLarge: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        titleMedium: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        titleSmall: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        headlineSmall: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        headlineMedium: TextStyle(
            color: new Color(0XFF4D358B),
        ),
        displaySmall: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        displayMedium: TextStyle(
          color: new Color(0XFF4D358B),
        ),
        labelLarge: TextStyle(color: Colors.white, fontSize: 18)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: false,
    ),
    // ... more
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.grey.withOpacity(0.25),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
        ),
        headlineSmall: TextStyle(
          color: Colors.white,
        ),
        displaySmall: TextStyle(
          color: Colors.white,
        ),
        displayMedium: TextStyle(
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          color: Colors.grey,
        ),
        titleSmall: TextStyle(
          color: Colors.grey,
        ),
        labelLarge: TextStyle(color: Colors.white, fontSize: 18)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      showUnselectedLabels: false,
    ),
    // ... more
  );
}
