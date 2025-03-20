import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController emailController,
    required this.labelText,
    required this.obText,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final String labelText;
  final bool obText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: CustomPadding.verticalMedium(),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(labelText: labelText),
        obscureText: obText,
      ),
    );
  }
}
