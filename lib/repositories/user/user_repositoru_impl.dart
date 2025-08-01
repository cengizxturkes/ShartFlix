import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<ProfileResponse> getProfile() {
    throw UnimplementedError();
  }
}
