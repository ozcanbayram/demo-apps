import 'package:delivery_app/product/custom/functions/custom_navigator.dart';
import 'package:delivery_app/product/custom/widgets/custom_container.dart';
import 'package:delivery_app/view/login_view.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool loginPressed = false;
  bool signUpPressed = true;

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
              loginPressed: () {
                navigateAndClose(context, const LoginView());
                _changeSelectedMaker();
              },
              signUpPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
