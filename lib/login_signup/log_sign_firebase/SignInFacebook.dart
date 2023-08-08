import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final FacebookAuth _facebookAuth = FacebookAuth.instance;

Future<User?> signInWithFacebook() async {
  try {
    // Trigger the authentication flow
    final LoginResult result = await _facebookAuth.login();

    // Obtain the auth details from the request
    final AccessToken accessToken = result.accessToken!;
    final String token = accessToken.token;

    // Create a new credential
    final AuthCredential credential = FacebookAuthProvider.credential(token);

    // Sign in to Firebase with the credential
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Return the user object
    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}
