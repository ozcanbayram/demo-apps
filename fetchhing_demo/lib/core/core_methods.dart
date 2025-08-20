import 'package:fetchhing_demo/view/home_page.dart';
import 'package:flutter/material.dart';

//NavigatorPush Method
void viewNavigator(BuildContext context) {
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (context) => HomePage()));
}
