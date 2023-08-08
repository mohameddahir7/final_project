// Edit_Profile.dart

import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        // automaticallyImplyLeading: true,
        // leading: IconButton(
        //   hoverColor: Colors.transparent,
        //   iconSize: 24,
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //     size: 24,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // title: const Text(
        //   'Edit Profile',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 16,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // actions: [],
        // centerTitle: true,
        // toolbarHeight: 430,
        // elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppUtils.circleEditImage(
                  imageProvider:const AssetImage('assets/images/instagram.png'),
                  onTap: () {}),
              // AppUtils.sizedBox(40.0, 0.0),
              // Align(
              //   alignment: const AlignmentDirectional(0, 0),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: Align(
              //           alignment: const AlignmentDirectional(0, 0),
              //           child: Container(
              //             width: 176,
              //             height: 176,
              //             decoration: const BoxDecoration(
              //               color: Color(0x58D9D9D9),
              //               shape: BoxShape.circle,
              //             ),
              //             child: Align(
              //               alignment: const AlignmentDirectional(0, 0),
              //               child: Stack(
              //                 children: [
              //                   Align(
              //                     alignment: const AlignmentDirectional(0, 0),
              //                     child: Container(
              //                       width: 144,
              //                       height: 144,
              //                       clipBehavior: Clip.antiAlias,
              //                       decoration: const BoxDecoration(
              //                         shape: BoxShape.circle,
              //                       ),
              //                       child: Image.asset(
              //                         'assets/images/WhatsApp_Image_2023-05-12_at_10.16.49_PM-removebg-preview-2.png',
              //                         fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                   ),
              //                   Align(
              //                     alignment:
              //                         const AlignmentDirectional(0.87, 0.66),
              //                     child: Container(
              //                       width: 50,
              //                       height: 50,
              //                       decoration: const BoxDecoration(
              //                         color: Color(0xFF506DF1),
              //                         shape: BoxShape.circle,
              //                       ),
              //                       child: IconButton(
              //                         iconSize: 24,
              //                         icon: const Icon(
              //                           Icons.photo_camera_outlined,
              //                           color: Colors.white,
              //                           size: 24,
              //                         ),
              //                         onPressed: () {
              //                           print('IconButton pressed ...');
              //                         },
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Column(
              //       mainAxisSize: MainAxisSize.max,
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
              //           child: Container(
              //             width: 354,
              //             decoration: const BoxDecoration(),
              //             child: Padding(
              //               padding: const EdgeInsetsDirectional.fromSTEB(
              //                   8, 0, 8, 0),
              //               child: TextFormField(
              //                 autofocus: true,
              //                 obscureText: false,
              //                 decoration: InputDecoration(
              //                   labelText: 'Username',
              //                   labelStyle: const TextStyle(
              //                     fontFamily: 'Inter',
              //                     fontWeight: FontWeight.w200,
              //                   ),
              //                   hintStyle: const TextStyle(
              //                     fontFamily: 'Readex Pro',
              //                     color: Colors.black,
              //                   ),
              //                   enabledBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.blue,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   focusedBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   errorBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   focusedErrorBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   suffixIcon: const Icon(
              //                     Icons.mode_edit,
              //                     color: Colors.black,
              //                     size: 24,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding:
              //               const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
              //           child: Container(
              //             width: 354,
              //             decoration: const BoxDecoration(),
              //             child: Padding(
              //               padding: const EdgeInsetsDirectional.fromSTEB(
              //                   8, 0, 8, 0),
              //               child: TextFormField(
              //                 autofocus: true,
              //                 obscureText: false,
              //                 decoration: InputDecoration(
              //                   labelText: 'Email',
              //                   labelStyle: const TextStyle(
              //                     fontFamily: 'Inter',
              //                     fontWeight: FontWeight.w200,
              //                   ),
              //                   hintStyle: const TextStyle(
              //                     fontFamily: 'Readex Pro',
              //                     color: Colors.black,
              //                   ),
              //                   enabledBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   focusedBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   errorBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   focusedErrorBorder: UnderlineInputBorder(
              //                     borderSide: const BorderSide(
              //                       color: Colors.white,
              //                       width: 2,
              //                     ),
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   suffixIcon: const Icon(
              //                     Icons.mode_edit,
              //                     color: Colors.black,
              //                     size: 24,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           width: 354,
              //           decoration: const BoxDecoration(),
              //           child: Padding(
              //             padding:
              //                 const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              //             child: TextFormField(
              //               autofocus: true,
              //               obscureText: false,
              //               decoration: InputDecoration(
              //                 labelText: 'Password',
              //                 labelStyle: const TextStyle(
              //                   fontFamily: 'Inter',
              //                   fontWeight: FontWeight.w200,
              //                 ),
              //                 hintStyle: const TextStyle(
              //                   fontFamily: 'Readex Pro',
              //                   color: Colors.black,
              //                 ),
              //                 enabledBorder: UnderlineInputBorder(
              //                   borderSide: const BorderSide(
              //                     color: Colors.white,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 focusedBorder: UnderlineInputBorder(
              //                   borderSide: const BorderSide(
              //                     color: Colors.white,
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 errorBorder: UnderlineInputBorder(
              //                   borderSide: const BorderSide(
              //                     color: Colors.white,
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 focusedErrorBorder: UnderlineInputBorder(
              //                   borderSide: const BorderSide(
              //                     color: Colors.white,
              //                     width: 2,
              //                   ),
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 suffixIcon: const Icon(
              //                   Icons.mode_edit,
              //                   color: Colors.black,
              //                   size: 24,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // Align(
              //   alignment: const AlignmentDirectional(0, 0),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () {
              //           print('Button pressed ...');
              //         },
              //         child: const Text("Update"),
              //       ),
              //     ],
              //   ),
              // ),
              ///text field for edit
              Column(
                children: [
                  AppUtils.searchTextField(
                    textInputAction: TextInputAction.next,
                    controller: name,
                    widget: Image.asset('assets/edit2.png'), onChanged: (query) {  },
                  ),
                  AppUtils.sizedBox(10.0, 0.0),
                  AppUtils.searchTextField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    widget: Image.asset('assets/edit2.png'), onChanged: (query) {  },
                  ),
                  AppUtils.sizedBox(10.0, 0.0),
                  AppUtils.searchTextField(
                    textInputAction: TextInputAction.done,
                    controller: password,
                    widget: Image.asset('assets/edit2.png'), onChanged: (query) {  },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: AppUtils.materialButton(
                  text: 'Update',
                  buttonWidth: double.infinity/1.1,
                  buttonColor: AppColors.blueColor,
                  onpress: (){},
                  context: context
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
