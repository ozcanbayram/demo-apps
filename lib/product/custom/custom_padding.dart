import 'package:flutter/material.dart';

class CustomPadding extends EdgeInsets {
  const CustomPadding.all() : super.all(16);
  const CustomPadding.verticalMedium() : super.symmetric(vertical: 16);
  const CustomPadding.horizontalMedium() : super.symmetric(horizontal: 16);
  const CustomPadding.horizontalLarge() : super.symmetric(horizontal: 32);
  const CustomPadding.customOnlysmall()
      : super.only(
          top: 8,
          bottom: 8,
          left: 32,
          right: 32,
        );
  const CustomPadding.customOnlyMedium()
      : super.only(
          top: 8,
          bottom: 16,
          left: 32,
          right: 32,
        );
}
