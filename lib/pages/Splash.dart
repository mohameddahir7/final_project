import 'dart:async';

import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';

import '../Utils/app_utils.dart';
import 'onbroad.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnbroadPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textBorderConColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            AppUtils.handWritten(),
            AppUtils.sizedBox(18.0, 0.0),
            AppUtils.linearIndicator(),
          ],
        ),
      ),
    );
  }
}
