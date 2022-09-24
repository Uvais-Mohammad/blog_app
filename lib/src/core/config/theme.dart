import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primarySwatch: black,
  scaffoldBackgroundColor: const Color(0xfff6f6f6),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    filled: true,
    fillColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      //make width to maximum
      minimumSize: MaterialStateProperty.all(
        const Size(double.infinity, 50.0),
      ),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black,
    thickness: 1.0,
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Colors.white,
    selectedColor: Colors.black,

    secondarySelectedColor: Colors.black,
    labelPadding: EdgeInsets.symmetric(
      horizontal: 10.0,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 10.0,
    ),
    shape: StadiumBorder(),
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    secondaryLabelStyle: TextStyle(
      color: Colors.white,
    ),
    brightness: Brightness.dark,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
  ),
  
);

const MaterialColor black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFE0E0E0),
    100: Color(0xFFB3B3B3),
    200: Color(0xFF808080),
    300: Color(0xFF4D4D4D),
    400: Color(0xFF262626),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
