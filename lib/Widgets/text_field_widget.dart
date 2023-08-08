import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget suffixWidget;
  final TextInputAction textInputAction;
  final bool check;

  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.suffixWidget,
        required  this.textInputAction,
        required this.check, required String? Function(String? value) validator, required bool obscureText,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textBorderConColor,
        border: Border.all(
          color: AppColors.whiteColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          textInputAction: textInputAction,
          controller: controller,
          cursorColor: AppColors.blueColor,
          obscureText: check,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.hintStyleColor,
              ),
              suffixIcon: suffixWidget),
        ),
      ),
    );
  }
}
