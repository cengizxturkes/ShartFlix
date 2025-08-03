import 'package:my_app/models/request/user/register/register_body.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/models/response/user/register/register_response.dart';
import 'package:my_app/models/token/token_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<LoginResponse?> signIn(String username, String password);

  Future<RegisterResponse> signUp(RegisterBody registerBody);

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<ProfileResponse?> getUser();
}
