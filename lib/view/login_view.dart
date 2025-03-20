import 'package:delivery_app/core/const/project_colors.dart';
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

  _changeSelectedMaker() {
    setState(() {
      loginPressed = !loginPressed;
      signUpPressed = !signUpPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
                loginSelected: loginPressed,
                signUpSelected: signUpPressed,
                loginPressed: () {},
                signUpPressed: () {
                  navigateAndClose(context, const SignUpView());
                  _changeSelectedMaker();
                }),
            Padding(
              padding: const CustomPadding.customOnlyLarge(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    emailController: _emailController,
                    labelText: 'Email',
                    obText: false,
                  ),
                  CustomTextField(
                    emailController: _passwordController,
                    labelText: 'Password',
                    obText: true,
                  ),
                  CustomTextButton(
                      onPressed: () {},
                      title: 'Forgot Password?',
                      selectedMaker: false,
                      color: ProjectColors.primary),
                ],
              ),
            ),
            CustomLargeButton(onPressed: () {}, title: 'Login'),
          ],
        ),
      ),
    );
  }
}
