import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';

class UpdateContainerWidget extends StatelessWidget {
  const UpdateContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: AppColors.whiteColor,
                spreadRadius: 2.2,
                blurRadius: 3.9,
                offset: Offset(2.0, 0.4))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppUtils.sizedBox(20.0, 0.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
            child: AppUtils.simpleText(
              text: AppUtils.updateDesc,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, height: 1.3),
            ),
          ),
          AppUtils.updateButton(
              onpress: () {},
              text: "Update",
              buttonColor: AppColors.blueColor,
              buttonWidth: 24,
              context: context),
          AppUtils.sizedBox(4.0, 0.0)
          // AppUtils.sizedBox(30.0, 0.0),
        ],
      ),
    );
  }
}
