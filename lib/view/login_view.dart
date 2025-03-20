import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/product/custom/functions/custom_navigator.dart';
import 'package:delivery_app/product/custom/widgets/custom_container.dart';
import 'package:delivery_app/product/custom/widgets/custom_large_button.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_button.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_field.dart';
import 'package:delivery_app/view/sign_up_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loginPressed = true;
  bool signUpPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTapBar(context),
            Padding(
              padding: const CustomPadding.customOnlyLarge(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  CustomTextField(
                    emailController: _emailController,
                    labelText: ProjectTexts.email,
                    obText: false,
                  ),
                  CustomTextField(
                    emailController: _passwordController,
                    labelText: ProjectTexts.password,
                    obText: true,
                  ),
                  CustomTextButton(
                    onPressed: () {},
                    title: ProjectTexts.forgotPassword,
                    selectedMaker: false,
                    color: ProjectColors.primary,
                  ),
                ],
              ),
            ),
            CustomLargeButton(
                onPressed: () {}, title: ProjectTexts.loginButton),
          ],
        ),
      ),
    );
  }

  _changeSelectedMaker() {
    setState(() {
      loginPressed = !loginPressed;
      signUpPressed = !signUpPressed;
    });
  }

  CustomContainer _buildTapBar(BuildContext context) {
    return CustomContainer(
        loginSelected: loginPressed,
        signUpSelected: signUpPressed,
        loginPressed: () {},
        signUpPressed: () {
          navigateAndClose(context, const SignUpView());
          _changeSelectedMaker();
        });
  }
}
