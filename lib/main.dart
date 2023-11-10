import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme=ColorScheme.fromSeed(seedColor: Colors.purple);
var kDarkColorScheme=ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: Color.fromARGB(255, 5, 99, 125));

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    home: Expenses(),
    darkTheme:ThemeData(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme: CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer
        )
      ),) ,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer
      ),
      cardTheme: CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer
        )
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 20,
        )
      )),
    
  ));
}