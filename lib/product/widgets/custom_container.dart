import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/enums/image_enum.dart';
import 'package:delivery_app/product/custom/custom_padding.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: CustomPadding.customOnlyLarge(),
            child: Center(child: ImageEnums.big_chef.toImage),
          ),
          child,
        ],
      ),
    );
  }
}
