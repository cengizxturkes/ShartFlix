import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/models/request/user/login/login_body.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/models/token/token_entity.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;

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
}
