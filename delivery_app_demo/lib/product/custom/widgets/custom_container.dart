import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/core/enums/image_enum.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.loginPressed,
    required this.signUpPressed,
    required this.loginSelected,
    required this.signUpSelected,
  });

  final VoidCallback loginPressed;
  final VoidCallback signUpPressed;
  final bool loginSelected;
  final bool signUpSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ProjectColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: ProjectColors.textSecondary,
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: CustomPadding.customOnlyLarge(),
            child: Center(child: ImageEnums.big_chef.toImage),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                title: ProjectTexts.loginButton,
                onPressed: loginPressed,
                selectedMaker: loginSelected,
              ),
              CustomTextButton(
                title: ProjectTexts.signUpButton,
                onPressed: signUpPressed,
                selectedMaker: signUpSelected,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
