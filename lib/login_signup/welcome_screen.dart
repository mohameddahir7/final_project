import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';

import '/login_signup/login_screen.dart';
import '/login_signup/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppUtils.sizedBox(30.0, 0.0),
            AppUtils.handWritten(),
            Image.asset(
              "assets/images/text_orc.jpg",
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width/ 1.2,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/sc_text.png",
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            AppUtils.sizedBox(24.0, 0.0),
            //buttons credentials
            Column(
              children: [
                //login button
                AppUtils.materialButton(
                  buttonWidth: MediaQuery.of(context).size.width / 1.2,
                  context: context,
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    text: "Login",
                    buttonColor: AppColors.loginColor),
                //register button
                AppUtils.sizedBox(8.0, 0.0),
                AppUtils.materialButton(
                  buttonWidth: MediaQuery.of(context).size.width / 1.2,
                  context: context,
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    text: "Sign Up",
                    buttonColor: AppColors.blueColor),
              ],
            ),
            AppUtils.sizedBox(8.0, 0.0),
          ],
        ),
      ),
    );
  }
}
