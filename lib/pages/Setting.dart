// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../login_signup/login_screen.dart';
// import 'Edit_Profile.dart';

// class SettingPage extends StatefulWidget {
//   const SettingPage({Key? key}) : super(key: key);

//   @override
//   State<SettingPage> createState() => _SettingPageState();
// }

// class _SettingPageState extends State<SettingPage> {
//   late User? currentUser;
//   DocumentSnapshot? userData;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser().then((user) {
//       setState(() {
//         currentUser = user;
//       });
//       getUserData();
//     });
//   }

//   Future<User?> getCurrentUser() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     return user;
//   }

//   Future<void> getUserData() async {
//     String userId = currentUser?.uid ?? '';
//     DocumentSnapshot snapshot =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     setState(() {
//       userData = snapshot;
//     });
//   }

//   Future<void> _refreshData() async {
//     getUserData();
//   }

//   Future<void> logoutUser() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       // Redirect or navigate to the login page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginScreen(),
//         ),
//       );
//     } catch (e) {
//       print('Error logging out: $e');
//     }
//   }

//   void navigateToEditProfile() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const EditProfileWidget(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: _refreshData,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(1, 0, 16, 8),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsetsDirectional.fromSTEB(125, 0, 0, 0),
//                         child: Container(
//                           width: 130,
//                           height: 130,
//                           decoration: const BoxDecoration(
//                             color: Color(0x58D9D9D9),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     15, 0, 0, 0),
//                                 child: Container(
//                                   width: 100,
//                                   height: 100,
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Image.network(
//                                     userData?['profileImageUrl'] ?? '',
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsetsDirectional.fromSTEB(41, 0, 0, 0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Text(
//                         userData?['username'] ?? 'User Name',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 0),
//                         child: Text(
//                           userData?['email'] ?? 'User Email',
//                           style: const TextStyle(
//                             fontFamily: 'Inter',
//                             color: Color(0xFF57636C),
//                             fontSize: 15,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         width: 399,
//                         height: 80,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: GestureDetector(
//                           onTap: navigateToEditProfile,
//                           child: const Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     20, 0, 20, 0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Icon(
//                                       Icons.person_sharp,
//                                       color: Colors.black,
//                                       size: 30,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           14, 0, 0, 0),
//                                       child: Text(
//                                         'Edit Profile',
//                                         style: TextStyle(
//                                           fontFamily: 'Inter',
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Align(
//                                         alignment: AlignmentDirectional(0.9, 0),
//                                         child: Icon(
//                                           Icons.arrow_forward_ios,
//                                           color: Colors.black,
//                                           size: 24,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     20, 17, 0, 0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Divider(
//                                       thickness: 1,
//                                       color: Color(0xFFC2C2C2),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 399,
//                         height: 80,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: const Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 0, 20, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Icon(
//                                     Icons.star_border,
//                                     color: Colors.black,
//                                     size: 30,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         14, 0, 0, 0),
//                                     child: Text(
//                                       'Favorite',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         color: Colors.black,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0.9, 0),
//                                       child: Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: Colors.black,
//                                         size: 24,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 17, 0, 0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Divider(
//                                     thickness: 1,
//                                     color: Color(0xFFC2C2C2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 399,
//                         height: 80,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: const Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 0, 20, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Icon(
//                                     Icons.all_out,
//                                     color: Colors.black,
//                                     size: 30,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         14, 0, 0, 0),
//                                     child: Text(
//                                       'About',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         color: Colors.black,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0.9, 0),
//                                       child: Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: Colors.black,
//                                         size: 24,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 17, 0, 0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Divider(
//                                     thickness: 1,
//                                     color: Color(0xFFC2C2C2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 399,
//                         height: 80,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: const Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 0, 20, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Icon(
//                                     Icons.code,
//                                     color: Colors.black,
//                                     size: 24,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         14, 0, 0, 0),
//                                     child: Text(
//                                       'About Developer',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         color: Colors.black,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0.9, 0),
//                                       child: Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: Colors.black,
//                                         size: 24,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 17, 0, 0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Divider(
//                                     thickness: 1,
//                                     color: Color(0xFFC2C2C2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: 399,
//                         height: 80,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         child: const Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 0, 20, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Icon(
//                                     Icons.notifications_none,
//                                     color: Colors.black,
//                                     size: 30,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         14, 0, 0, 0),
//                                     child: Text(
//                                       'Notification',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter',
//                                         color: Colors.black,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0.9, 0),
//                                       child: Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: Colors.black,
//                                         size: 24,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 17, 0, 0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Divider(
//                                     thickness: 1,
//                                     color: Color(0xFFC2C2C2),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // First Logout code
//                       Padding(
//                         padding:
//                             const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                         child: GestureDetector(
//                           onTap:
//                               logoutUser, // Call logoutUser function when tapped
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Icon(
//                                 Icons.logout,
//                                 color: Colors.black,
//                                 size: 30,
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsetsDirectional.fromSTEB(14, 0, 0, 0),
//                                 child: Text(
//                                   'LogOut',
//                                   style: TextStyle(
//                                     fontFamily: 'Inter',
//                                     color: Colors.black,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Align(
//                                   alignment: AlignmentDirectional(0.9, 0),
//                                   child: Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: Colors.black,
//                                     size: 24,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // End logout
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_utils.dart';
import '../login_signup/login_screen.dart';
import '../pages/About.dart';
import '../pages/Edit_Profile.dart';
import '../pages/about_developer.dart';
import '../pages/favourite.dart';
import '../pages/notifications.dart';

///new code for settings screen

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // Variables to store the user information
  late String username;
  late String email;
  String? profileImageUrl; // Variable to store the profile image URL

  @override
  void initState() {
    super.initState();
    // Get the current user information after the widget is initialized
    getCurrentUserInfo();
  }

  // Function to get the current user information from Firebase
  void getCurrentUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        // Store the user information in the variables
        username = user.displayName ?? "";
        email = user.email ?? "";
        // You can also get the user's profile image URL here, if it is available in Firebase Auth
        profileImageUrl = user.photoURL;
      });
    }
  }
  
  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect or navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              AppUtils.sizedBox(60.0, 0.0),
              CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.greyWhiteColor,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!) // Display the user's profile image if available
                    : null, // If profileImageUrl is null, don't show any image
                child: const CircleAvatar(
                  radius: 46,
                ),
              ),
              AppUtils.sizedBox(8.0, 0.0),
              AppUtils.simpleText(
                text: username, // Display the username here
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              AppUtils.simpleText(
                text: email, // Display the email here
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor),
              ),
              //list tile set
              AppUtils.sizedBox(40.0, 0.0),
              AppUtils.editProfile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfileWidget(),
                      ),
                    );
                  },
                  text: "Edit profile",
                  imagePath: "assets/profile.png"),
              AppUtils.divide(),
              AppUtils.editProfile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Favourite(),
                      ),
                    );
                  },
                  text: "Favourite ",
                  imagePath: "assets/changepass.png"),
              AppUtils.divide(),
              AppUtils.editProfile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const About(),
                      ),
                    );
                  },
                  text: "About",
                  imagePath: "assets/chat.png"),
              AppUtils.divide(),
              AppUtils.editProfile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AboutDeveloper(),
                      ),
                    );
                  },
                  text: "About Developer",
                  imagePath: "assets/develop.png"),
              AppUtils.divide(),
              AppUtils.editProfile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Notifications(),
                      ),
                    );
                  },
                  text: "Notification",
                  imagePath: "assets/notifi.png"),
              AppUtils.divide(),
              AppUtils.editProfile(
                  onTap: logoutUser, text: "LogOut", imagePath: "assets/logout.png"),
            ],
          ),
        ),
      ),
    );
  }
}
