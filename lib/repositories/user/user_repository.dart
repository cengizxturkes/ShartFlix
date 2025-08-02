import 'dart:io';

import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/upload_photo/upload_photo_response.dart';

abstract class UserRepository {
  Future<LoginResponse> login(String email, String password);
  Future<UploadPhotoResponse> uploadProfilePhoto(File file);
}
