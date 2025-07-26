import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
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

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: CustomPadding.all(),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: ProjectColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              // BoxShadow(
              //   color: ProjectColors.textSecondary,
              //   spreadRadius: 2,
              //   blurRadius: 5,
              //   offset: const Offset(0, 3),
              // ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: ProjectTexts.searchField,
              prefixIcon: const Icon(Icons.search),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: CustomPadding.verticalMedium(),
            ),
          ),
        ),
      ),
    );
  }
}
