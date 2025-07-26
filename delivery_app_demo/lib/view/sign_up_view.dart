import 'package:delivery_app/core/const/project_texts.dart';
import 'package:delivery_app/product/custom/functions/custom_navigator.dart';
import 'package:delivery_app/product/custom/widgets/custom_container.dart';
import 'package:delivery_app/product/custom/widgets/custom_large_button.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_field.dart';
import 'package:delivery_app/view/login_view.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  bool loginPressed = false;
  bool signUpPressed = true;

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
                  CustomTextField(
                    emailController: _emailController,
                    labelText: ProjectTexts.email,
                    obText: false,
                  ),
                  CustomTextField(
                    emailController: _passwordController,
                    labelText: ProjectTexts.password,
                    obText: false,
                  ),
                  CustomTextField(
                    emailController: _passwordAgainController,
                    labelText: ProjectTexts.passwordAgain,
                    obText: true,
                  ),
                ],
              ),
            ),
            CustomLargeButton(
                onPressed: () {}, title: ProjectTexts.signUpButton),
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
      loginPressed: () {
        navigateAndClose(context, const LoginView());
        _changeSelectedMaker();
      },
      signUpPressed: () {},
    );
  }
}
