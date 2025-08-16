import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/logger/logger.dart';

class GoogleSignInService {
  static final GoogleSignInService _instance = GoogleSignInService._internal();
  factory GoogleSignInService() => _instance;
  GoogleSignInService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Sign in with Google and return the ID token for backend authentication
  Future<String?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // User canceled the sign-in
        Logger.instance.i('Google sign-in canceled by user');
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      // Get the ID token from Firebase
      final String? idToken = await userCredential.user?.getIdToken();
      
      if (idToken != null) {
        Logger.instance.i('Google sign-in successful, got ID token');
        return idToken;
      } else {
        Logger.instance.e('Failed to get ID token from Firebase user');
        return null;
      }
    } catch (error) {
      Logger.instance.e('Google sign-in error: $error');
      return null;
    }
  }

  /// Sign out from Google and Firebase
  Future<void> signOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _firebaseAuth.signOut(),
      ]);
      Logger.instance.i('Google sign-out successful');
    } catch (error) {
      Logger.instance.e('Google sign-out error: $error');
    }
  }

  /// Check if user is currently signed in
  bool get isSignedIn {
    return _firebaseAuth.currentUser != null;
  }

  /// Get current user info
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }
}