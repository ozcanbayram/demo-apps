import 'package:flutter/material.dart';

class CustomPadding extends EdgeInsets {
  const CustomPadding.all() : super.all(16);
  const CustomPadding.verticalMedium() : super.symmetric(vertical: 16);
  const CustomPadding.horizontalMedium() : super.symmetric(horizontal: 16);
  const CustomPadding.customOnly()
      : super.only(
          top: 8,
          bottom: 8,
          left: 32,
          right: 32,
        );
}
