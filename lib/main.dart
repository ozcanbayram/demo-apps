import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/view/theme_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ProjectColors.transparant,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ProjectTexts.appName,
      theme: lightTheme,
      home: ThemeExamlView(),
    );
  }
}
