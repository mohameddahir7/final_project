import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import '../Widgets/text_field_widget.dart';
import '../login_signup/register_screen.dart';
import '../pages/Setting.dart';
import '../pages/home.dart';
import 'log_sign_firebase/Applid.dart';
import 'log_sign_firebase/SignInFacebook.dart';
import 'log_sign_firebase/SignInGoogle.dart';
import 'log_sign_firebase/login_firebase.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginScreenFirebase _loginScreenFirebase = LoginScreenFirebase();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields'),
        ),
      );
      return;
    }

    final success = await _loginScreenFirebase.loginUser(email, password);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
        ),
      );
      Navigator.pop(context);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
     return null;
  }

  bool _passwordVisible = false; // Add this variable for password visibility

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppUtils.sizedBox(20.0, 0.0),
            AppUtils.handWritten(),
            // AppUtils.sizedBox(70.0, 0.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUtils.simpleText(
                  text: "Login to your account",
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 24
                  )
                ),
                AppUtils.sizedBox(12.0, 0.0),
                TextFieldWidget(
                  check: false,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  validator: _validateEmail,
                  obscureText: !_passwordVisible,
                  hintText: "Email",
                  suffixWidget: AppUtils.sizedBox(0.0, 0.0),
                ),

                AppUtils.sizedBox(14.0, 0.0),
                TextFieldWidget(
                  check: true,
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  validator: _validatePassword,
                  obscureText: !_passwordVisible,
                  hintText: 'Password',
                  suffixWidget: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.blueColor,
                        ),
                      ),
                ),
                AppUtils.sizedBox(24.0, 0.0),
                // login button
                Center(
                  child: AppUtils.materialButton(
                    context: context,
                    onpress: _login,
                    text: "Login",
                    buttonColor: AppColors.blueColor,
                    buttonWidth: MediaQuery.of(context).size.width / 1.1,
                  ),
                ),
                AppUtils.sizedBox(44.0, 0.0),
                Column(
                  children: [
                    Row(
                      children: [
                        AppUtils.divideLine(),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text("Or Sign in With"),
                        ),
                        AppUtils.divideLine()
                      ],
                    ),
                    AppUtils.sizedBox(60.0, 0.0),
                    //credentials buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppUtils.credentialsButtons(
                            userCredentialTap: () async {
                              final User? user = await signInWithFacebook();
                              if (user != null) {
                                // Navigate to home screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              }
                            },
                            imageName: 'assets/fb.png'),
                        AppUtils.credentialsButtons(
                            userCredentialTap: () async {
                              final User? user = await signInWithGoogle();
                              if (user != null) {
                                // Navigate to home screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              }
                            },
                            imageName: 'assets/google.png'),
                        AppUtils.credentialsButtons(
                            userCredentialTap: () async {
                              final User? user = await signInWithApple();
                              if (user != null) {
                                // Navigate to home screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingPage(),
                                  ),
                                );
                              }
                            },
                            imageName: 'assets/apple.png')
                       
                      ],
                    ),
                  ],
                ),
              ],
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppUtils.sizedBox(0.0, 4.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 97, 131, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                AppUtils.sizedBox(120.0, 0.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
