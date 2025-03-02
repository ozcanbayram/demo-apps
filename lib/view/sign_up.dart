import 'package:delivery_app/core/const/project_colors.dart';
import 'package:delivery_app/product/custom/custom_large_button.dart';
import 'package:delivery_app/product/custom/custom_padding.dart';
import 'package:delivery_app/product/widgets/custom_container.dart';
import 'package:delivery_app/view/login_view.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(child: _buildTabBar(context)),
            _buildSignUpForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabItem(context, 'Login', false),
        _buildTabItem(context, 'Sign-up', true),
      ],
    );
  }

  Widget _buildTabItem(BuildContext context, String title, bool isSelected) {
    return TextButton(
      onPressed: () {
        if (title == 'Login') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginView();
              },
            ),
          );
        }
      },
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 3.0,
              width: 100.0,
              color: ProjectColors.primary,
            ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Padding(
      padding: CustomPadding.customOnlyLarge(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _emailController,
            labelText: 'Email',
          ),
          const SizedBox(height: 20.0),
          _buildTextField(
            controller: _passwordController,
            labelText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          _buildTextField(
            controller: _passwordAgainController,
            labelText: 'Password Again',
            obscureText: true,
          ),
          const SizedBox(height: 10.0),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                // Forgot password action
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: ProjectColors.primary),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          CustomLargeButton(
            onPressed: () {
              // Sign up action
            },
            title: 'Sign Up',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: ProjectColors.textSecondary),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.primary),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.textSecondary),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ProjectColors.primary, width: 2.0),
        ),
      ),
    );
  }
}
