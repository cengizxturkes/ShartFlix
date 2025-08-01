import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/models/token/token_entity.dart';
import 'package:my_app/network/api_client/api_client.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String username, String password);

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
