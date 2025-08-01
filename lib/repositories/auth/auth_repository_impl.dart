import 'package:my_app/database/secure_storage_helper.dart';
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
  Future<TokenEntity?> signIn(String username, String password) async {
    //Todo
    await Future.delayed(const Duration(seconds: 2));
    return TokenEntity(
      accessToken: 'app_access_token',
      refreshToken: 'app_refresh_token',
    );
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
}
