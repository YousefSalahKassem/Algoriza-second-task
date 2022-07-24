import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class Themes {
  static ThemeData darkThem = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkmodeColor,
    primaryColor: defaultDarkColor,
    primarySwatch: defaultLightColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: darkmodeColor,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkmodeColor,
          statusBarIconBrightness: Brightness.light,
        )),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultDarkColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkmodeColor.withOpacity(0.8),
        selectedItemColor: defaultDarkColor,
        unselectedItemColor: Colors.grey.withOpacity(0.6)),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      headline5:
          TextStyle(color: defaultDarkColor, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primarySwatch: defaultLightColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 10),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: defaultLightColor),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
          color: Colors.black,
        ),
        subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        headline5:
            TextStyle(color: defaultLightColor, fontWeight: FontWeight.bold)),
  );
}
