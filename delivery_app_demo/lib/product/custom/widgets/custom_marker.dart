import 'package:delivery_app/core/const/project_colors.dart';
import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      height: 3,
      width: 100,
      color: ProjectColors.primary,
    );
  }
}
