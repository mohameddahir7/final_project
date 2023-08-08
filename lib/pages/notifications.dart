// // import '/flutter_flow/flutter_flow_animations.dart';
// // import '/flutter_flow/flutter_flow_icon_button.dart';
// // import '/flutter_flow/flutter_flow_theme.dart';
// // import '/flutter_flow/flutter_flow_util.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart'
//     as smooth_page_indicator;
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// // import 'about_model.dart';
// // export 'about_model.dart';
//
// class AboutWidget extends StatefulWidget {
//   const AboutWidget({Key? key}) : super(key: key);
//
//   @override
//   _AboutWidgetState createState() => _AboutWidgetState();
// }
//
// class _AboutWidgetState extends State<AboutWidget>
//     with TickerProviderStateMixin {
//   late AboutModel _model;
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   final animationsMap = {
//     'imageOnPageLoadAnimation1': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: 0,
//           end: 1,
//         ),
//         ScaleEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: Offset(1.2, 1.2),
//           end: Offset(1, 1),
//         ),
//       ],
//     ),
//     'imageOnPageLoadAnimation2': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: 0,
//           end: 1,
//         ),
//         ScaleEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: Offset(1.2, 1.2),
//           end: Offset(1, 1),
//         ),
//       ],
//     ),
//     'imageOnPageLoadAnimation3': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: 0,
//           end: 1,
//         ),
//         ScaleEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: Offset(1.2, 1.2),
//           end: Offset(1, 1),
//         ),
//       ],
//     ),
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => AboutModel());
//
//     setupAnimations(
//       animationsMap.values.where((anim) =>
//           anim.trigger == AnimationTrigger.onActionTrigger ||
//           !anim.applyInitialState),
//       this,
//     );
//   }
//
//   @override
//   void dispose() {
//     _model.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(0, -1),
//                 child: Container(
//                   width: double.infinity,
//                   height: 384,
//                   child: Stack(
//                     children: [
//                       PageView(
//                         controller: _model.pageViewController ??=
//                             PageController(initialPage: 0),
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Stack(
//                                 children: [
//                                   Image.network(
//                                     'https://static.nike.com/a/images/f_auto,b_rgb:f5f5f5,w_880/b74f8933-b681-499a-91f5-d74aee3389bb/sportswear-womens-oversized-fleece-hoodie-qVwpDl.png',
//                                     width: double.infinity,
//                                     height: 330,
//                                     fit: BoxFit.cover,
//                                   ).animatedOnPageLoad(animationsMap[
//                                       'imageOnPageLoadAnimation1']!),
//                                   Align(
//                                     alignment:
//                                         AlignmentDirectional(-0.94, -0.63),
//                                     child: Padding(
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           0, 10, 0, 0),
//                                       child: IconButton(
//                                         hoverColor: Colors.transparent,
//                                         // borderRadius: 20,
//                                         // borderWidth: 0,
//                                         iconSize: 24,
//                                         icon: Icon(
//                                           Icons.arrow_back,
//                                           color: Color(0xFF4365FF),
//                                           size: 24,
//                                         ),
//                                         onPressed: () {
//                                           print('IconButton pressed ...');
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Image.network(
//                                 'https://static.nike.com/a/images/f_auto,b_rgb:f5f5f5,w_880/f5be788a-4531-450e-9954-603e10d75daf/epic-luxe-womens-mid-rise-trail-running-leggings-N5wX3G.png',
//                                 width: double.infinity,
//                                 height: 330,
//                                 fit: BoxFit.cover,
//                               ).animatedOnPageLoad(
//                                   animationsMap['imageOnPageLoadAnimation2']!),
//                             ],
//                           ),
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Image.network(
//                                 'https://static.nike.com/a/images/f_auto,b_rgb:f5f5f5,w_880/9d1e8941-ec91-490f-b1ac-db44a0068a82/quest-4-womens-road-running-shoes-LM6nH6.png',
//                                 width: double.infinity,
//                                 height: 330,
//                                 fit: BoxFit.cover,
//                               ).animatedOnPageLoad(
//                                   animationsMap['imageOnPageLoadAnimation3']!),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional(0, 1),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
//                           child: smooth_page_indicator.SmoothPageIndicator(
//                             controller: _model.pageViewController ??=
//                                 PageController(initialPage: 0),
//                             count: 3,
//                             axisDirection: Axis.horizontal,
//                             onDotClicked: (i) async {
//                               await _model.pageViewController!.animateToPage(
//                                 i,
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease,
//                               );
//                             },
//                             effect: const smooth_page_indicator.ExpandingDotsEffect(
//                               expansionFactor: 2,
//                               spacing: 8,
//                               radius: 16,
//                               dotWidth: 16,
//                               dotHeight: 4,
//                               dotColor: Color(0x4C4B39EF),
//                               activeDotColor: Color(0xFF4B39EF),
//                               paintStyle: PaintingStyle.fill,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                 child: Container(
//                   width: 375,
//                   height: 243,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   alignment: const AlignmentDirectional(0, -1),
//                   child: const Text(
//                     'FlutterFlow is a visual development platform that allows you to easily create beautiful and responsive user interfaces for your mobile and web applications. its drag-and-drop interface and pre-built components, you can quickly prototype and build your app without writing any code.  you can quickly prototype and build your app without writing any code.  you can quickly prototype and build your app without writing any code. With  its drag-and-drop interface and pre-built components, you can quickly prototype and build your app without writing any code.  you can quickly prototype and build your app without writing any code.  you can quickly prototype and build your app without writing any code. With',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                 ),
//               ),
//               Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsetsDirectional.fromSTEB(25, 25, 25, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Stack(
//                               children: [
//                                 Container(
//                                   width: 12,
//                                   height: 12,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFF4365FF),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 12,
//                                   height: 12,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFF4365FF),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsetsDirectional.fromSTEB(
//                                   0, 5, 0, 0),
//                               child: Container(
//                                 width: 2,
//                                 height: 100,
//                                 decoration: const BoxDecoration(
//                                   color: Color(0xFF4365FF),
//                                 ),
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       width: 2,
//                                       height: 100,
//                                       decoration: const BoxDecoration(
//                                         color: Color(0xFF4365FF),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding:
//                               const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Mission',
//                                 style: TextStyle(
//                                   fontFamily: 'Urbanist',
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                               Container(
//                                 width: 279,
//                                 height: 100,
//                                 decoration: const BoxDecoration(),
//                                 child: const Text(
//                                   'FlutterFlow is a visual development platform that allows you to easily create beautiful and responsive user interfaces for your mobile and web applications. With its drag-and-drop interface and pre-built components, FlutterFlow is a visual',
//                                   style: TextStyle(
//                                     fontFamily: 'Urbanist',
//                                     color: Colors.black,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsetsDirectional.fromSTEB(25, 25, 25, 0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Stack(
//                                 children: [
//                                   Container(
//                                     width: 12,
//                                     height: 12,
//                                     decoration: const BoxDecoration(
//                                       color: Color(0xFF4365FF),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 12,
//                                     height: 12,
//                                     decoration: const BoxDecoration(
//                                       color: Color(0xFF4365FF),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 12,
//                                     height: 12,
//                                     decoration: const BoxDecoration(
//                                       color: Color(0xFF4365FF),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     0, 5, 0, 0),
//                                 child: Container(
//                                   width: 2,
//                                   height: 100,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFF4365FF),
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       Container(
//                                         width: 2,
//                                         height: 100,
//                                         decoration: const BoxDecoration(
//                                           color: Color(0xFF4365FF),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Mission',
//                                   style: TextStyle(
//                                     fontFamily: 'Urbanist',
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 279,
//                                   height: 100,
//                                   decoration: BoxDecoration(),
//                                   child: const Text(
//                                     'FlutterFlow is a visual development platform that allows you to easily create beautiful and responsive user interfaces for your mobile and web applications. With its drag-and-drop interface and pre-built components, FlutterFlow is a visual',
//                                     style: TextStyle(
//                                       fontFamily: 'Urbanist',
//                                       color: Colors.black,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import '../Widgets/update_container_widget.dart';

///new code for about page user

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: AppUtils.simpleText(
          text: "Notifications",
          style: const TextStyle(
              fontSize: 22,
              color: AppColors.blueColor,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            AppUtils.sizedBox(20.0, 0.0),
            const UpdateContainerWidget(),
            AppUtils.sizedBox(20.0, 0.0),
            const UpdateContainerWidget()
          ],
        ),
      ),
    );
  }
}
