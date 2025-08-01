import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/network/api_client/api_client.dart';

abstract class UserRepository {
  Future<ProfileResponse> getProfile();
}
