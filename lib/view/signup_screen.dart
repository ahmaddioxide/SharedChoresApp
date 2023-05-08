import 'package:choresmate/ui-components/custom-widgets/transparent_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:choresmate/ui-components/theme.dart';
import 'package:choresmate/ui-components/custom-widgets/app_name.dart';
import 'package:choresmate/ui-components/custom-widgets/black_text.dart';
import 'package:choresmate/ui-components/custom-widgets/custom-button.dart';
import 'package:choresmate/ui-components/custom-widgets/grey_text.dart';
import 'package:choresmate/ui-components/custom-widgets/custom_textformfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _screenWidth * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppNameText(),
                const GreyText(
                  text: "Chores Management App",
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
                ),
                const BlackText(
                  text: "Create your account",
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
                ),
                const CustomTextFormField(
                  hintText: "Username",
                  icon: Icons.person_2_rounded,
                  isPasswordField: false,
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
                ),
                const CustomTextFormField(
                  hintText: "Email",
                  icon: Icons.email_rounded,
                  isPasswordField: false,
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
                ),
                const CustomTextFormField(
                  hintText: "Password",
                  icon: Icons.lock_rounded,
                  isPasswordField: true,
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
                ),
                const CustomTextFormField(
                  hintText: "Confirm Password",
                  icon: Icons.lock_rounded,
                  isPasswordField: true,
                ),

                SizedBox(
                  height: _screenHeight * 0.05, 
                ),
                BlueButton(
                  onPressed: () {},
                  buttonText: "Register",
                  width: 0.85,
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: _screenHeight * 0.03,
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
          ), /**/
        ),
      ),
    );
  }
}
