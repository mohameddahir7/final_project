import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import '../Widgets/text_field_widget.dart';
import '../pages/home.dart';
import '../pages/setting.dart';
import 'log_sign_firebase/SignInFacebook.dart';
import 'log_sign_firebase/SignInGoogle.dart';
import 'log_sign_firebase/register_firebase.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // File? _profileImage;
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  // final _usernameController = TextEditingController();

  File? _profileImage;
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final bool _passwordVisible = false;

  Future<void> _pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _profileImage = imageTemporary);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image error: $e');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
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
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // // registerUser
  // void _submitForm() async {
    // if (_formKey.currentState!.validate()) {
    //   try {
    //     String? userId = await RegisterScreenFirebase().registerUser(
    //       email: _emailController.text.trim(),
    //       password: _passwordController.text.trim(),
    //       username: _usernameController.text.trim(),
    //       profileImage: _profileImage,
    //     );

    //   if (userId != null) {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const Home(),
    //         ),
    //       );
    //     } else {
    //       // Handle registration failure.
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: const Text("Registration Failed"),
    //           content: const Text("An error occurred while registering the user."),
    //           actions: <Widget>[
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text("OK"),
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //   } on EmailAlreadyInUseException catch (e) {
    //     // Handle email already in use error.
    //     debugPrint(e.message);
    //   } on WeakPasswordException catch (e) {
    //     // Handle weak password error.
    //     debugPrint(e.message);
    //   } on InvalidEmailException catch (e) {
    //     // Handle invalid email error.
    //     debugPrint(e.message);
    //   } on RegistrationFailedException catch (e) {
    //     // Handle registration failed error.
    //     debugPrint(e.message);
    //   } catch (e) {
    //     // Handle any other unexpected errors.
    //     debugPrint('An unexpected error occurred while registering the user.');
    //   }
    // }
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppUtils.sizedBox(90.0, 0.0),
            AppUtils.handWritten(),
            AppUtils.sizedBox(20.0, 0.0),
            AppUtils.circleEditImage(
              onTap: _pickProfileImage,
              imageProvider: _profileImage != null ? FileImage(_profileImage!) :const AssetImage('assets/fake_image.jpg') as ImageProvider,
            ),
   
            AppUtils.sizedBox(40.0, 0.0),
            TextFieldWidget(
              check: false,
              textInputAction: TextInputAction.next,
              controller: _usernameController,
              validator: _validateUsername,
              obscureText: !_passwordVisible,
              hintText: "User name",
              suffixWidget: AppUtils.sizedBox(0.0, 0.0),
            ),
            AppUtils.sizedBox(14.0, 0.0),
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
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              validator: _validatePassword,
              obscureText: !_passwordVisible,
              hintText: "Password",
              //suffixWidget:const Icon(Icons.visibility,color: AppColors.blueColor,),
               suffixWidget: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: AppColors.blueColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
            ),
            AppUtils.sizedBox(14.0, 0.0),
            
            TextFieldWidget(
              check: true,
              textInputAction: TextInputAction.done,
              controller: _confirmPasswordController,
              validator: _validateConfirmPassword,
              obscureText: !_passwordVisible,
              hintText: "Confirm Password",
             // suffixWidget:const Icon(Icons.visibility,color: AppColors.blueColor,),
             suffixWidget: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: AppColors.blueColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
            ),
            AppUtils.sizedBox(30.0, 0.0),
            AppUtils.materialButton(
                buttonWidth: MediaQuery.of(context).size.width / 1.1,
                context: context,
                onpress: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      String? userId = await RegisterScreenFirebase().registerUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        username: _usernameController.text.trim(),
                        profileImage: _profileImage,
                      );

                    if (userId != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      } else {
                        // Handle registration failure.
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Registration Failed"),
                            content: const Text("An error occurred while registering the user."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    } on EmailAlreadyInUseException catch (e) {
                      // Handle email already in use error.
                      debugPrint(e.message);
                    } on WeakPasswordException catch (e) {
                      // Handle weak password error.
                      debugPrint(e.message);
                    } on InvalidEmailException catch (e) {
                      // Handle invalid email error.
                      debugPrint(e.message);
                    } on RegistrationFailedException catch (e) {
                      // Handle registration failed error.
                      debugPrint(e.message);
                    } catch (e) {
                      // Handle any other unexpected errors.
                      debugPrint('An unexpected error occurred while registering the user.');
                    }
                  }
                },
                // onpress: () async {
                //   final String? userId =
                //       await RegisterScreenFirebase().registerUser(
                //     email: _emailController.text.trim(),
                //     password: _passwordController.text.trim(),
                //     username: _usernameController.text.trim(),
                //     profileImage: _profileImage,
                //   );
                //   if (userId != null) {
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const Home(),
                //       ),
                //     );
                //   } else {
                //     // Handle error
                //   }
                // },
                text: "Sign Up",
                buttonColor: AppColors.blueColor),
           
            AppUtils.sizedBox(20.0, 0.0),
            Row(
              children: [
                AppUtils.divideLine(),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text("Or sign Up with"),
                ),
                AppUtils.divideLine(),
              ],
            ),
            AppUtils.sizedBox(20.0, 0.0),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final User? user = await signInWithFacebook();
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE8ECF4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          "assets/fb.png",
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final User? user = await signInWithGoogle();
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingPage(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE8ECF4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          "assets/google.png",
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE8ECF4),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/apple.png",
                        height: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppUtils.sizedBox(20.0, 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
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
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color.fromARGB(255, 97, 131, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
