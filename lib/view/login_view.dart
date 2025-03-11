import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/enums/image_enum.dart';
import 'package:delivery_app/product/custom/widgets/custom_large_button.dart';
import 'package:delivery_app/product/custom/widgets/custom_padding.dart';
import 'package:delivery_app/product/custom/widgets/custom_text_files.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                      TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Text(
                              'Login',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              height: 3.0,
                              width: 100.0,
                              color: ProjectColors.primary,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginView();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign-up',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: ProjectColors.primary),
                    ),
                  ),
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
