import 'dart:io';

import 'package:my_app/models/request/user/login/login_body.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/upload_photo/upload_photo_response.dart';

import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/repositories/user/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<LoginResponse> login(String email, String password) async {
    final response = await apiClient.authLogin(
      LoginBody(email: email, password: password),
    );
    return response;
  }

  @override
  Future<UploadPhotoResponse> uploadProfilePhoto(File file) async {
    final response = await apiClient.uploadProfilePhoto(file);
    return response;
  }
}
