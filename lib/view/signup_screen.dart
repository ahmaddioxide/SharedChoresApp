import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../controller/authentication_controller.dart';
import '../constants/validators.dart';
import '../ui-components/app_name.dart';
import '../ui-components/black_text.dart';
import '../ui-components/custom_button.dart';
import '../ui-components/custom_textformfield.dart';
import '../ui-components/grey_text.dart';
import '../ui-components/theme.dart';
import '../ui-components/transparent_appbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const BlueAppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppNameText(),
                const GreyText(
                  text: "Chores Management App",
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                const BlackText(
                  text: "Create your account",
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Form(
                  // key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: "Username",
                        icon: Icons.person_2_rounded,
                        isPasswordField: false,
                        controller: _usernameController,
                      ),
                      SizedBox(
                        height: height * 0.03,
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
                        height: height * 0.03,
                      ),
                      CustomTextFormField(
                        hintText: "Confirm Password",
                        icon: Icons.lock_rounded,
                        isPasswordField: true,
                        controller: _confirmPasswordController,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      BlueButton(
                        onPressed: () {
                          _register(context);
                        },
                        buttonText: "Register",
                        width: 0.85,
                      ),
                    ],
                  ),
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
                      text: 'Already have account? ',
                      style: TextStyle(
                        fontSize: 17,
                        color: CustomColorSwatch.subheadingColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        fontSize: 17,
                        color: CustomColorSwatch.pimary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                          debugPrint('Login Text Clicked');
                        },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _register(context) {
    if (nameValidator(_usernameController.text.toString().trim()) == "" &&
        emailValidator(_emailController.text.toString().trim()) == "" &&
        passwordValidator(_passwordController.text.toString().trim()) == "" &&
        confirmPasswordValidator(
          _passwordController.text.toString().trim(),
          _confirmPasswordController.text.toString().trim(),
        )) {
      AuthenticationController.registerUser(
        context,
        _usernameController.text.toString().trim(),
        _emailController.text.toString().trim(),
        _passwordController.text.toString().trim(),
      );
      return true;
    } else {
      String error = "";
      if (nameValidator(_usernameController.text.toString().trim()) != "") {
        error = nameValidator(_usernameController.text.toString().trim());
      } else if (emailValidator(_emailController.text.toString().trim()) !=
          "") {
        error = emailValidator(_emailController.text.toString().trim());
      } else if (passwordValidator(
              _passwordController.text.toString().trim()) !=
          "") {
        error = passwordValidator(_passwordController.text.toString().trim());
      } else if (!confirmPasswordValidator(
        _passwordController.text.toString().trim(),
        _confirmPasswordController.text.toString().trim(),
      )) {
        error = "Passwords do not match";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error),
        ),
      );
      return false;
    }
  }
}
