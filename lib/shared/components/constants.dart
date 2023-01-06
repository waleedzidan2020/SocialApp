import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

const String LoginPath = 'login';
const String Home = 'home';
const String category = 'categories';
const String Favorites = "favorites";
const String Register = "register";
const String Profile = "profile";
const String LogOut = "logout";
const String updateprofile = "update-profile";

//

String? UserId;
bool? IsDataSuccess;

Widget? BaseScreen;

ThemeData DarkTheme = ThemeData(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orangeAccent),
      ),
      labelStyle: TextStyle(color: Colors.orangeAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orangeAccent,
        ),
      ),
    ),
    textTheme: TextTheme(),
    scaffoldBackgroundColor: Colors.black12,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black12,
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "Oswald",
        fontSize: 25,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.orangeAccent,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          color: Colors.orangeAccent,
        )));
ThemeData LightTheme = ThemeData(
    iconTheme: IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: "Oswald",
        fontSize: 25,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Colors.blue,
        )));
