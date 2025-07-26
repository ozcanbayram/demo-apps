import 'package:delivery_app/core/const/core_sizes.dart';
import 'package:delivery_app/core/const/project_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ProjectColors.backgroundPrimary,
  useMaterial3: true,
  primaryColor: ProjectColors.primary,

  //! Text theme
  textTheme: const TextTheme(
      headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: ProjectColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
      headlineLarge: TextStyle(
          fontSize: CoreSizes.headlineLargeSize,
          fontWeight: FontWeight.bold,
          color: ProjectColors.white),
      displayMedium: TextStyle(fontWeight: FontWeight.bold)),

  //! AppBar action button theme
  appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: ProjectColors.transparant,
      foregroundColor: Colors.black,
      centerTitle: true),

  //! Floating Action button theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
  ),

  //! Elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(ProjectColors.primary),
      foregroundColor: WidgetStateProperty.all(ProjectColors.white),
      // side: WidgetStateProperty.all(
      //   BorderSide(
      //        width: 1.0,
      //        color: ProjectColors.transparant,
      //        style: BorderStyle.solid),),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    ),
  ),

  //! TextField theme
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: ProjectColors.textSecondary),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: ProjectColors.primary),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ProjectColors.textSecondary),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: ProjectColors.primary, width: 2.0),
    ),
  ),
);
