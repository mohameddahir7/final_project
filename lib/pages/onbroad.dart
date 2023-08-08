import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';

import '/login_signup/welcome_screen.dart';

class OnbroadPage extends StatefulWidget {
  const OnbroadPage({Key? key}) : super(key: key);

  @override
  State<OnbroadPage> createState() => _OnbroadPageState();
}

class _OnbroadPageState extends State<OnbroadPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.handWritten(),
              Center(
                child: Image.asset(
                  'assets/images/sdd.png',
                  width: MediaQuery.of(context).size.height / 2.8,
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppUtils.appText(
                        text: 'Simple way to scan',
                        butonColor: AppColors.blackColor,
                        fntsize: 22,
                        fontWei: FontWeight.w700),
                    AppUtils.sizedBox(6.0, 0.0),
                    AppUtils.appText(
                        text: 'We believe this App will help you ,',
                        butonColor: Colors.black,
                        fntsize: 14,
                        fontWei: FontWeight.w500),
                    AppUtils.appText(
                        text: 'WELCOME our Scanner App',
                        butonColor: Colors.black,
                        fntsize: 14,
                        fontWei: FontWeight.w500),
                  ],
                ),
              ),
              AppUtils.showOnBroadScreen(onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const WelcomeScreen();
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
