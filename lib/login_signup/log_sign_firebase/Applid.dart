// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// Future<User?> signInWithApple() async {
//   try {
//     // Trigger the authentication flow
//     final AuthorizationResult result =
//         await SignInWithApple.getAuthorizationResult();

//     // Obtain the auth details from the request
//     final String? identityToken = result.credential?.identityToken;
//     final String? nonce = result.credential?.nonce;

//     // Create a new credential
//     final AuthCredential credential = OAuthProvider('apple.com').credential(
//       idToken: identityToken!,
//       rawNonce: nonce!,
//     );

//     // Sign in to Firebase with the credential
//     final UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signInWithApple() async {
  return null;
  // try {
  //   // Trigger the authentication flow
  //   final AuthorizationResult result = await SignInWithApple.signIn();
  //
  //   // Obtain the auth details from the request
  //   final String? identityToken = result.credential?.identityToken;
  //   final String? nonce = result.credential?.nonce;
  //
  //   // Create a new credential
  //   final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
  //   final AuthCredential credential = oAuthProvider.credential(
  //     idToken: identityToken!,
  //     rawNonce: nonce!,
  //   );
  //
  //   // Sign in to Firebase with the credential
  //   final UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //   // Return the user object
  //   return userCredential.user;
  // } catch (e) {
  //   print(e);
  //   return null;
  // }
}
