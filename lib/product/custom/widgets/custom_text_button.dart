import 'package:delivery_app/product/custom/widgets/custom_marker.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.selectedMaker,
    this.color,
  });

  final VoidCallback onPressed;
  final String title;
  final bool selectedMaker;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                ),
          ),
          selectedMaker ? CustomMarker() : SizedBox(),
        ],
      ),
    );
  }
}
