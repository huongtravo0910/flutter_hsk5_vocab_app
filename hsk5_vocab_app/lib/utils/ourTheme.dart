import 'package:flutter/material.dart';

class OurTheme {
  Color _brownLight = Color.fromARGB(255, 237, 225, 165);
  Color _brownDark = Color.fromARGB(255, 73, 57, 32);
  Color _red = Color.fromARGB(255, 186, 1, 31);
  Color _green = Color.fromARGB(255, 83, 148, 60);
  Color _greyLight = Color.fromARGB(255, 171, 162, 119);

  ThemeData buildTheme() {
    return ThemeData(
        canvasColor: _brownLight,
        primaryColor: _brownLight,
        secondaryHeaderColor: _brownDark,
        accentColor: _red,
        hintColor: _greyLight,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: _greyLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: _greyLight),
            ),
            hintStyle: TextStyle(fontSize: 14)),
        buttonTheme: ButtonThemeData(
          buttonColor: _red,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          minWidth: 150,
          height: 40.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            //14
            color: _brownDark,
          ),
          bodyText1: TextStyle(
            //16
            color: Colors.black,
          ),
          button: TextStyle(
            color: _brownLight,
          ),
          headline6: TextStyle(
            //16
            color: Colors.black,
          ),
          headline4: TextStyle(
            //20
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: TextStyle(
            //20
            fontFamily: 'Ruda',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          subtitle2: TextStyle(
            //20
            color: _brownLight,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
