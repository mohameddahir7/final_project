import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/Utils/app_colors.dart';

class AppUtils {
  static Widget sizedBox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Widget appText(
      {required String text,
      required Color butonColor,
      required double fntsize,
      required FontWeight fontWei}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: butonColor,
        fontSize: fntsize,
        fontWeight: fontWei,
      ),
    );
  }

  static Widget handWritten() {
    return Center(
      child: AppUtils.appText(
          text: 'Hand writing',
          butonColor: AppColors.blueColor,
          fntsize: 30,
          fontWei: FontWeight.bold),
    );
  }

  static Widget simpleText({required String text, required TextStyle style}) {
    return Text(
      text,
      style: style,
    );
  }

  static Widget materialButton(
      {required Function() onpress,
      required String text,
      required Color buttonColor,
      required double buttonWidth,
      required BuildContext context}) {
    return MaterialButton(
      minWidth: buttonWidth,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      onPressed: onpress,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }


  static Widget updateButton(
      {required Function() onpress,
        required String text,
        required Color buttonColor,
        required double buttonWidth,
        required BuildContext context}) {
    return MaterialButton(
      minWidth: buttonWidth,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onpress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }



  static Widget divideLine() {
    return const Expanded(
      child: Divider(
        color: AppColors.whiteColor,
        thickness: 1,
      ),
    );
  }

  static credentialsButtons(
      {required Function() userCredentialTap, required String imageName}) {
    return GestureDetector(
      onTap: userCredentialTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.white,
                blurRadius: 2,
                spreadRadius: 3,
                offset: Offset(0.1, 0.2))
          ],
          border: Border.all(
            color: AppColors.whiteColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            imageName,
            height: 32,
          ),
        ),
      ),
    );
  }

  //check account buttons
  // static Widget checkAccountButtons(){
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Text(
  //         "Don’t have an account? ",
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       AppUtils.sizedBox(0.0, 4.0),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const RegisterScreen(),
  //             ),
  //           );
  //         },
  //         child: const Text(
  //           "Sign Up",
  //           style: TextStyle(
  //             color: Color.fromARGB(255, 97, 131, 255),
  //             fontSize: 16,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  static Widget searchTextField(
      {required TextEditingController controller,
      required Widget widget,
      required TextInputAction textInputAction, required void Function(dynamic query) onChanged}) {
    return Material(
      color: Colors.grey.withOpacity(0.1),
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        cursorColor: AppColors.blueColor,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(horizontal: 22),
          suffixIcon: widget,
          filled: true,
          hintText: "Search",
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  //divide
  static Widget divide() {
    return const Divider(
      thickness: 2.1,
    );
  }

  //list tile for edit profile users
  static Widget editProfile(
      {required imagePath, required String text, required Function() onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(imagePath),
      title: AppUtils.simpleText(
        text: text,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.blackColor,
      ),
    );
  }

  //circle image for change sign up screen
  static Widget circleEditImage(
      {required ImageProvider imageProvider, required Function() onTap}) {
    return CircleAvatar(
      radius: 52,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: imageProvider,
      child: Stack(
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.camera_alt_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //circle for edit profile page

  // static Widget circleEditPage({required ImageProvider imageProvider,required Function() onTap}){
  //   return SizedBox(
  //     width: 130,
  //     height: 130,
  //     child: CircleAvatar(
  //       backgroundColor: Colors.grey.shade200,
  //       backgroundImage:imageProvider,
  //       child: Stack(
  //         children: [
  //           Positioned(
  //             bottom: 5,
  //             right: 5,
  //             child: GestureDetector(
  //               onTap: onTap,
  //               child: Container(
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: AppColors.blueColor,
  //                   border: Border.all(color: Colors.white, width: 3),
  //                   borderRadius: BorderRadius.circular(25),
  //                 ),
  //                 child: const Icon(
  //                   Icons.camera_alt_sharp,
  //                   color: Colors.white,
  //                   size: 25,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }



  // //show fav documents list tile
  static Widget showFavDocuments({required Function() onTap, required String documentName, required String documentType, required String documentUrl}) {
    return ListTile(
      onTap: onTap,
      // contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      tileColor: AppColors.greyWhiteColor,
      minVerticalPadding: 0.0,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset('assets/Microsoft Word.png'),
          ),
        ],
      ),
      title: AppUtils.simpleText(
        text: "Math Formula",
        style: const TextStyle(),
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppUtils.simpleText(
            text: "2.3 mb, .Xixs",
            style: const TextStyle(),
          ),
          AppUtils.sizedBox(0.0, 4.0),
          AppUtils.simpleText(
            text: "/download/documents",
            style: const TextStyle(color: AppColors.blueColor),
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset('assets/magicstar.png'),
      ),
    );
  }


  //about image container
  static Widget aboutImageCon() {
    return Container(
      // height: 210,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
            image: AssetImage('assets/about_image.png'), fit: BoxFit.cover),
      ),
    );
  }

  //about developer image container
  //about image container
  static Widget aboutDeveloperImageCon() {
    return Container(
      // height: 210,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
            image: AssetImage('assets/two.png'), fit: BoxFit.cover),
      ),
    );
  }

  static String desc =
      "Waraa application that is scanning handwriting  image text and document image text  the application uses where input image/camera that scanning and text recognize then convert documents into editable text. the application provides the option to export the scanned text into different file formats such as docx, ppt, excel, and pdf. The application also saves user data in the cloud on Firestore or on mobile storage file, allowing users to access any users their special documents by using email and password with online and able to use with but must be first to login with internet then the application work with offline";

  static String flowDesc =
      "FlutterFlow is a visual development platform that allows you to easily create beautiful and responsive user interfaces for your mobile and web applications. With its drag-and-drop interface and pre-built components, FlutterFlow is a visual output.";
  static String developerDesc =
      "Abdiwali Axmed maxamud Lorem ipsum dolor sit amet, quis vel erat. Vestibulum vel facilisis ex. Morbi finibus est et mauris pretium ultricies. Sed semper neque nec hendrerit vestibulum.";
  static String updateDesc =
      "Our mission is to empower users to effortlessly digitize and manage their handwritten and document texts. Through our intuitive and user-friendly Flutter application, we aim to provide seamless scanning and text recognition capabilities, converting physical documents into editable digital files. We are dedicated to offering a wide range of export options, allowing users to save their scanned text in various formats such as docx, ppt, excel, and pdf. By enabling cloud storage integration, we provide a secure and accessible platform for users to store their important documents, ensuring they can access them anytime, anywhere, with an internet connection.";

  static Widget linearIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 74.0),
      child: LinearProgressIndicator(
        backgroundColor: AppColors.blueColor,
        valueColor: AlwaysStoppedAnimation(AppColors.greyWhiteColor),
        minHeight: 6,
      ),
    );
  }

  static Widget showOnBroadScreen({required Function() onTap}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 34.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(130, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppColors.blueColor),
          onPressed: onTap,
          child: const Text("Get Started"),
        ),
      ),
    );
  }

  //show flush bar
  static showFlushBar(BuildContext context, String message) {
    Flushbar(
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      backgroundGradient: LinearGradient(
        colors: [
          AppColors.blueColor,
          AppColors.blueColor.withOpacity(0.7),
          AppColors.blueColor.withOpacity(0.5),
        ],
        stops: const [0.4, 0.7, 1],
      ),
      boxShadows: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      icon: const Icon(
        Icons.warning,
        color: Colors.red,
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderRadius: BorderRadius.circular(4),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      message: message,
      messageSize: 17,
    ).show(context);
  }

  //description of the title
  static Widget desTitle({required String text}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 8.0,
          backgroundColor: AppColors.blueColor,
        ),
        AppUtils.sizedBox(0.0, 8.0),
        AppUtils.simpleText(text: text, style: const TextStyle(fontSize: 16))
      ],
    );
  }

  //description of the mission detail
  static Widget description({required String descri}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 4.0),
            width: 6.0,
            height: 116,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColors.blueColor),
          ),
          AppUtils.sizedBox(0.0, 8.0),
          Flexible(
            child: AppUtils.simpleText(
              text: descri,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  static Widget aboutDeveloperImageConWithDesc({required String imagePath}) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(imagePath),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppUtils.simpleText(
                  text: "Abdiwali Ahmed Mohamud",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                AppUtils.simpleText(
                  text: AppUtils.developerDesc,
                  style: const TextStyle(),
                ),
               
              ],
            ),
          ),
        ),
      ],
    );
  }
}
