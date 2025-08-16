import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/models/request/user/login/login_body.dart';
import 'package:my_app/models/request/user/login/google_sign_in.dart';
import 'package:my_app/models/request/user/register/register_body.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/login/google_sign_in_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/models/response/user/register/register_response.dart';
import 'package:my_app/models/token/token_entity.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<LoginResponse?> signIn(String email, String password) async {
    final response = await apiClient.authLogin(
      LoginBody(email: email, password: password),
    );
    return response;
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Future<ProfileResponse?> getUser() async {
    final response = await apiClient.getProfile();
    return response;
  }

  @override
  Future<GoogleSignInResponse?> signInWithGoogle() async {
    try {
      // Google Sign-In işlemi
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In iptal edildi');
      }

      // Google authentication credentials'ları al
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Firebase credential oluştur
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase ile giriş yap
      final UserCredential firebaseUser = await _firebaseAuth.signInWithCredential(credential);
      
      // Firebase ID token al
      final String? idToken = await firebaseUser.user?.getIdToken();
      
      if (idToken == null) {
        throw Exception('Firebase ID token alınamadı');
      }

      // Backend'e ID token gönder
      final response = await apiClient.googleLogin(
        GoogleSignInBody(idToken: idToken),
      );
      
      return response;
    } catch (e) {
      throw Exception('Google Sign-In hatası: ${e.toString()}');
    }
  }

  @override
  Future<RegisterResponse> signUp(RegisterBody registerBody) async {
    final response = await apiClient.register(registerBody);
    return response;
  }
}
