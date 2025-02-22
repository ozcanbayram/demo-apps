import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/core/enums/image_enum.dart';
import 'package:delivery_app/product/custom/custom_large_button.dart';
import 'package:delivery_app/product/custom/custom_padding.dart';
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
      body: Column(
        children: [
          Container(
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
                      onPressed: () {},
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
          Expanded(
            child: Padding(
              padding: CustomPadding.customOnlyLarge(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: ProjectColors.textSecondary),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: ProjectColors.primary),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ProjectColors.textSecondary),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ProjectColors.primary, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: ProjectColors.textSecondary),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: ProjectColors.primary),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ProjectColors.textSecondary),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ProjectColors.primary, width: 2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password action
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: ProjectColors.primary),
                      ),
                    ),
                  ),
                  const Spacer(), // Boş alanı doldurur
                  CustomLargeButton(
                    onPressed: () {
                      // Login action
                    },
                    title: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
