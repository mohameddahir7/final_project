import 'package:firebase_auth/firebase_auth.dart';

class LoginScreenFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
