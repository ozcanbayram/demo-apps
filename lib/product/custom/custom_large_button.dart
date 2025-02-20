import 'package:delivery_app/core/const/core_sizes.dart';
import 'package:delivery_app/product/custom/custom_padding.dart';
import 'package:flutter/material.dart';

class CustomLargeButton extends StatelessWidget {
  const CustomLargeButton({
    super.key,
    required this.onPressed,
    this.bgColor,
    required this.title,
    this.frColor,
  });
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? frColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.customOnly(),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: frColor,
          minimumSize: const Size(double.infinity, CoreSizes.largeButtonHeight),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: CoreSizes.largeButtontextSize,
          ),
        ),
      ),
    );
  }
}
