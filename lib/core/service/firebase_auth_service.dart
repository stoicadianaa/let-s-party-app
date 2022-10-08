import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> mailSignIn(String? mail, String? pwd) async {
    try {
      if (mail == null || pwd == null) return "Empty mail or password";
      await _auth.signInWithEmailAndPassword(email: mail, password: pwd);
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }

  Future<String?> createAccount(String? mail, String? pwd) async {
    try {
      if (mail == null || pwd == null) return "Empty mail or password";
      await _auth
          .createUserWithEmailAndPassword(email: mail, password: pwd);
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
    }
  }
}
