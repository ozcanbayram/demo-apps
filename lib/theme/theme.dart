import 'package:delivery_app/core/const/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ProjectColors.background,
  useMaterial3: true,
  primaryColor: ProjectColors.primary,

  //! Text theme
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: ProjectColors.textPrimary),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
  ),

  //! AppBar action button theme
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: ProjectColors.transparant,
      foregroundColor: Colors.black,
      centerTitle: true),

  //! Floating action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
  ),
);
