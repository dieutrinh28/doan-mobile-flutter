import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

class GoogleAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      CalendarApi.calendarScope,
    ]
  );
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(googleCredential);
        return userCredential;
      } else {
        print('Google signing in failed');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.disconnect();
      await googleSignIn.signOut();
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      print('Error to sign out: $e');
    }
  }

  Future<String?> getAccessToken() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final String accessToken = googleAuth.accessToken!;
        return accessToken;
      } else {
        print('Google signing in failed');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }


}
