import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    selectedItemColor: Colors.amber,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,

  ) ,
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.amber,
  fontFamily: 'janna',


  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ) ,

    color: Colors.white,
    elevation: 0.0,
  ),

);


ThemeData darkTheme = ThemeData(
  fontFamily: 'janna',
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    selectedItemColor: Colors.amber,

    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,

  ) ,
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.amber,

  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white70,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white70,
      size: 30.0,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ) ,

    color: Colors.white,
    elevation: 0.0,
  ),
);