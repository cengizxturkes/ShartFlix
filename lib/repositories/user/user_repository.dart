import 'package:my_app/models/response/user/login/login_response.dart';

abstract class UserRepository {
  Future<LoginResponse> login(String email, String password);
}
