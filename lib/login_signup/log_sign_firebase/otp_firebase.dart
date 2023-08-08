// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../create_password_screen.dart';
//
// late final String email;
//
// Future<void> _verifyOTP(BuildContext context, String otp) async {
//   try {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('password_reset_codes')
//         .where('email', isEqualTo: email)
//         .orderBy('timestamp', descending: true)
//         .limit(1)
//         .get();
//     final docSnapshot = querySnapshot.docs.first;
//     if (docSnapshot.exists) {
//       final code = docSnapshot.id;
//       if (otp == code) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => CreatePasswordScreen(email: email)),
//         );
//         return;
//       }
//     }
//     // Handle incorrect OTP
//     print('Incorrect OTP');
//   } catch (error) {
//     // Handle the error
//     print('Error verifying OTP: $error');
//   }
// }
