import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/core/enums/image_enum.dart';
import 'package:delivery_app/product/custom/widgets/custom_large_button.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:flutter/material.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: CustomPadding.customOnlysmall(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageEnums.chef.toImage,
                Text(
                  ProjectTexts.onboardTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          ImageEnums.splash.toImage,
          CustomLargeButton(
            bgColor: ProjectColors.white,
            frColor: ProjectColors.primary,
            title: ProjectTexts.getSartedButton,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
