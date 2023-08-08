import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/app_colors.dart';

import '../Screen/export_next.dart';

// import '../Screen/Document_export.dart';
import '../Utils/image_cropper_page.dart';
import '../Utils/image_picker_class.dart';
import '../Widgets/dialog.dart';
import '../pages/Dashboard.dart';
// import '../pages/Dash.dart';
import 'Setting.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    const SettingPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashboardPage();

  Future<void> _refreshData() async {
    // Implement your refresh logic here
    setState(() {
      // Update the data or perform any necessary operations
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add),
        onPressed: () {
          imagePickerModal(context, onCameraTap: () {
            log("Camera");
            pickImage(source: ImageSource.camera).then((value) {
              if (value != '') {
                imageCropperView(value, context).then((value) {
                  if (value != '') {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => RecognizePage(
                          path: value,
                        ),
                      ),
                    );
                  }
                });
              }
            });
          }, onGalleryTap: () {
            log("Gallery");
            pickImage(source: ImageSource.gallery).then((value) {
              if (value != '') {
                imageCropperView(value, context).then((value) {
                  if (value != '') {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => RecognizePage(
                          path: value,
                        ),
                      ),
                    );
                  }
                });
              }
            });
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =  const DashboardPage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/tab_one.jpg',scale: 1.1)
                        // Icon(
                        //   Icons.document_scanner,
                        //   color: currentTab == 0 ? Colors.blue : Colors.grey,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              // Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const SettingPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab == 1 ? AppColors.blueColor : Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
///new code for bottom navigation bar














// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:virtual_app/pages/Dashboard.dart';
// import 'package:virtual_app/pages/Setting.dart';
//
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//
//   final List _screenList =  [
//     DashboardPage(),
//     SettingPage(),
//     const SettingPage(),
//     // HomeCategoryScreen(),
//     // // HomeBottomScreen(),
//     // Orders(),
//     // HomeCategoryScreen(),
//     // Chats(),
//     // Profile(),
//   ];
//   int _cIndex = 3;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _animationController = AnimationController(
//   //     vsync: this,
//   //     duration: const Duration(milliseconds: 500),
//   //   );
//   // }
//
//   // @override
//   // void dispose() {
//   //   _animationController.dispose();
//   //   super.dispose();
//   // }
//
//   // void _onPressed() {
//   //   if (_animationController.isDismissed) {
//   //     _animationController.forward();
//   //   } else {
//   //     _animationController.reverse();
//   //   }
//   // }
//   // bool _isFirstIcon = true;
//   @override
//   Widget build(BuildContext context) {
//     return Placeholder(
//         child: Scaffold(
//           // appBar: AppBar(
//           //   title: Text('Bottom Navigation Bar'),
//           // ),
//             body: _screenList[_cIndex],
//             bottomNavigationBar: ConvexAppBar(
//               // curve: 20,
//               // curveSize:120,
//               // height: 120,
//               height: 38,
//               // top: 120,
//               curveSize: 100,
//               cornerRadius: 20,
//               backgroundColor: Colors.white,
//               elevation: 0.0,
//               // gradient:  LinearGradient(
//               //     // colors: AppUtils.gradientColors,
//               //     begin: Alignment.bottomLeft,
//               //     end: Alignment.bottomRight),
//               style: TabStyle.fixedCircle,
//               items: [
//                 TabItem(icon: Image.asset('assets/tab_one.jpg')),
//                 TabItem(icon: Icon(Icons.add)),
//                 TabItem(icon: Icon(Icons.settings)),
//                 // TabItem(
//                 //     activeIcon: Image.asset('assets/home-Filled.png',scale: 0.1,),
//                 //     icon: Image.asset('assets/home-Regular.png',scale: 0.1,),
//                 //     title: (context, "home")),
//                 // TabItem(
//                 //     activeIcon: Image.asset(
//                 //       'assets/package-Filled.png',
//                 //       scale: 0.1,
//                 //     ),
//                 //     icon: Image.asset(
//                 //       'assets/package-Regular.png',
//                 //       scale: 0.1,
//                 //       // scale: 0.001,
//                 //     ),
//                 //     title: Locales.string(context, 'order')),
//                 // TabItem(
//                 //   // activeIcon: CircleAvatar(
//                 //   //   // backgroundColor: Colors.red,
//                 //   //   // backgroundColor: Color(0xff#FFEA17),
//                 //   //   // radius: 40,
//                 //   //   child: Center(
//                 //   //     child: Image.asset(
//                 //   //       'assets/bottom_img.png',
//                 //   //       // scale: 0.1,
//                 //   //       // fit: BoxFit.contain,
//                 //   //     ),
//                 //   //   ),
//                 //   //   // backgroundColor: Colors.red,
//                 //   // ),
//                 //     icon: Container(
//                 //       decoration: BoxDecoration(
//                 //           image: DecorationImage(image: AssetImage('assets/circle_color.png'),scale: 0.1)
//                 //       ),
//                 //       child: Center(child: Icon(Icons.shopping_basket,color: Colors.white,),),
//                 //     )),
//                 // TabItem(
//                 //     icon: Image.asset(
//                 //       'assets/comment-dots-Regular.png',
//                 //       scale: 0.1,
//                 //     ),
//                 //     activeIcon: Image.asset(
//                 //       'assets/comment-dots-Filled.png',
//                 //       scale: 0.1,
//                 //     ),
//                 //     title: Locales.string(context, 'chat')),
//                 // TabItem(
//                 //     activeIcon: Image.asset(
//                 //       'assets/user-Filled.png',
//                 //       scale: 0.1,
//                 //     ),
//                 //     icon: Image.asset(
//                 //       'assets/user-Regular.png',
//                 //       scale: 0.1,
//                 //     ),
//                 //     title: Locales.string(context, 'profile')),
//               ],
//               // initialActiveIndex: 2,
//               onTap: (int i) => _incrementTab(i),
//             )));
//   }
//
//   void _incrementTab(index) {
//     setState(() {
//       _cIndex = index;
//     });
//   }
// }
