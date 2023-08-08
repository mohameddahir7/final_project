import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//final TextEditingController _emailController = TextEditingController();

Future<void> _sendPasswordResetCode(BuildContext context, String email) async {
  try {
    await FirebaseFirestore.instance.collection('password_reset_codes').add({
      'email': email,
      'timestamp': DateTime.now(),
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const OTPScreen(email: 'email')),
    // );
  } catch (error) {
    // Handle the error
    print('Error sending password reset code: $error');
  }
}
