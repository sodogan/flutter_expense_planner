import 'package:flutter/material.dart';

ThemeData myCustomLightTheme() {
  final ThemeData _lightTheme = ThemeData.light();

  final _appBarTextTheme = _lightTheme.textTheme.copyWith(
    headline6: const TextStyle(
      fontFamily: 'Quicksand-Bold',
      color: Colors.white,
      fontSize: 18,
    ),
  );

  final _textTheme = _lightTheme.textTheme.copyWith(
    headline2: const TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16,
      color: Colors.black,
    ),
    headline5: const TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 16,
      color: Colors.grey,
    ),
    headline6: const TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    button: const TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontSize: 18,
    ),
  );

  return ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      errorColor: Colors.purple,
      textTheme: _textTheme,
      colorScheme: ColorScheme.dark(
        onPrimary: Colors.indigo,
        onSecondary: Colors.amber,
      ),
      appBarTheme: AppBarTheme(
        elevation: 12,
        textTheme: _appBarTextTheme,
      ));
}
