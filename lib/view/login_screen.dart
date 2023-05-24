import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:choresmate/view/signup_screen.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'package:choresmate/ui-components/app_name.dart';


import '../constants/validators.dart';
import '../controller/authentication_controller.dart';
import '../ui-components/black_text.dart';
import '../ui-components/blue_text.dart';
import '../ui-components/custom_button.dart';
import '../ui-components/custom_textformfield.dart';
import '../ui-components/grey_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    bool login() {
      if (emailValidator(_emailController.text.toString().trim()) == "" &&
          passwordValidator(_passwordController.text.toString().trim()) == "") {
        AuthenticationController.loginUser(
          context,
          _emailController.text.toString().trim(),
          _passwordController.text.toString().trim(),
        );
        return true;
      } else {
        String error = "";
        if (emailValidator(_emailController.text.toString().trim()) != "") {
          error = emailValidator(_emailController.text.toString().trim());
        } else if (passwordValidator(
                _passwordController.text.toString().trim()) !=
            "") {
          error = passwordValidator(_passwordController.text.toString().trim());
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.001,
                  ),
                  const AppNameText(),
                  const GreyText(
                    text: "Chores Management App",
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  const BlackText(
                    text: "Login to your account",
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  CustomTextFormField(
                    hintText: "Email",
                    icon: Icons.email_rounded,
                    isPasswordField: false,
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomTextFormField(
                    hintText: "Password",
                    icon: Icons.lock_rounded,
                    isPasswordField: true,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint("Forgot Password Clicked");
                          },
                          child: const BlueText(
                            text: "Forgot Password?",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  BlueButton(
                    onPressed: () {
                      debugPrint("Login Button Clicked");
                      if (login()) {

                      }

                    },
                    buttonText: "Login",
                    width: 0.85,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 17,
                          color: CustomColorSwatch.subheadingColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Register Now',
                        style: const TextStyle(
                          fontSize: 17,
                          color: CustomColorSwatch.pimary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                            debugPrint('Login Text Clicked');
                          },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ), /**/
        ),
      ),
    );
  }

}
