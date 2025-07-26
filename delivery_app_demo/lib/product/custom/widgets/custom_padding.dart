import 'package:flutter/material.dart';

class CustomPadding extends EdgeInsets {
  const CustomPadding.all() : super.all(16);
  const CustomPadding.topAndBottom() : super.only(top: 16, bottom: 16);
  const CustomPadding.verticalMedium() : super.symmetric(vertical: 16);
  const CustomPadding.horizontalMedium() : super.symmetric(horizontal: 16);
  const CustomPadding.horizontalLarge() : super.symmetric(horizontal: 32);
  const CustomPadding.customOnlyXsmall()
      : super.only(
          top: 0,
          bottom: 0,
          left: 32,
          right: 32,
        );
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
  const CustomPadding.customOnlyLarge()
      : super.only(
          top: 32,
          bottom: 32,
          left: 32,
          right: 32,
        );
  const CustomPadding.customOnlyXLarge()
      : super.only(
          top: 64,
          bottom: 64,
          left: 32,
          right: 32,
        );
}
