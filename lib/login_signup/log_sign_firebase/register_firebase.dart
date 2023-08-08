// // import 'dart:async';
// // import 'dart:io';
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// //
// // class RegisterScreenFirebase {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final CollectionReference _usersCollection =
// //       FirebaseFirestore.instance.collection('users');
// //
// //   Future<String?> registerUser(
// //       {required String email,
// //       required String password,
// //       required String username,
// //       File? profileImage}) async {
// //     try {
// //       // Create user in Firebase Authentication
// //       final UserCredential userCredential =
// //           await _auth.createUserWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //
// //       // Upload profile image to Firebase Storage if provided
// //       String? profileImageUrl;
// //       if (profileImage != null) {
// //         final Reference storageReference = FirebaseStorage.instance
// //             .ref()
// //             .child('profile_images/${userCredential.user!.uid}.jpg');
// //         final TaskSnapshot downloadUrl =
// //             await storageReference.putFile(profileImage);
// //         profileImageUrl = await downloadUrl.ref.getDownloadURL();
// //       }
// //
// //       // Save user data to Firestore
// //       await _usersCollection.doc(userCredential.user!.uid).set({
// //         'email': email,
// //         'password': password,
// //         'username': username,
// //         'profileImageUrl': profileImageUrl,
// //       });
// //
// //       // Return user ID
// //       return userCredential.user!.uid;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     }
// //   }
// // }


// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class RegisterScreenFirebase {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final CollectionReference _usersCollection =
//   FirebaseFirestore.instance.collection('users');

//   Future<String?> registerUser({
//     required String email,
//     required String password,
//     required String username,
//     File? profileImage,
//   }) async {
//     try {
//       // Create user in Firebase Authentication
//       final UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Upload profile image to Firebase Storage if provided
//       String? profileImageUrl;
//       if (profileImage != null) {
//         final Reference storageReference = FirebaseStorage.instance
//             .ref()
//             .child('profile_images/${userCredential.user!.uid}.jpg');
//         final TaskSnapshot downloadUrl =
//         await storageReference.putFile(profileImage);
//         profileImageUrl = await downloadUrl.ref.getDownloadURL();
//       }

//       // Save user data to Firestore
//       await _usersCollection.doc(userCredential.user!.uid).set({
//         'email': email,
//         'username': username,
//         'profileImageUrl': profileImageUrl,
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       // Return user ID
//       return userCredential.user!.uid;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } on FirebaseException catch (e) {
//       return e.message;
//     } catch (e) {
//       return 'An error occurred while registering the user';
//     }
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreenFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String?> registerUser({
    required String email,
    required String password,
    required String username,
    File? profileImage,
  }) async {
    try {
      // Create user in Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Upload profile image to Firebase Storage if provided
      String? profileImageUrl;
      if (profileImage != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_images/${userCredential.user!.uid}.jpg');
        final TaskSnapshot downloadUrl =
            await storageReference.putFile(profileImage);
        profileImageUrl = await downloadUrl.ref.getDownloadURL();
      }

      // Save user data to Firestore
      await _usersCollection.doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
        'profileImageUrl': profileImageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Return user ID
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException('The email address is already in use.');
      } else if (e.code == 'weak-password') {
        throw WeakPasswordException('The password provided is too weak.');
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailException('The email address is not valid.');
      } else {
        throw RegistrationFailedException('An error occurred while registering the user.');
      }
    } on FirebaseException catch (e) {
      throw RegistrationFailedException('An error occurred while registering the user.');
    } catch (e) {
      throw RegistrationFailedException('An error occurred while registering the user.');
    }
  }
}

// Custom exceptions
class EmailAlreadyInUseException implements Exception {
  final String message;
  EmailAlreadyInUseException(this.message);
}

class WeakPasswordException implements Exception {
  final String message;
  WeakPasswordException(this.message);
}

class InvalidEmailException implements Exception {
  final String message;
  InvalidEmailException(this.message);
}

class RegistrationFailedException implements Exception {
  final String message;
  RegistrationFailedException(this.message);
}
