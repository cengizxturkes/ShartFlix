// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/models/token/token_entity.dart';

class SecureStorageHelper {
  // The value stored in SecureStore will not be deleted when the app is uninstalled.
  static const _apiTokenKey = 'api_token';
  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _loginResponseKey = 'login_response';

  final FlutterSecureStorage _storage;

  SecureStorageHelper._(this._storage);

  static final SecureStorageHelper _instance = SecureStorageHelper._(
    const FlutterSecureStorage(),
  );

  static SecureStorageHelper get instance => _instance;

  //Save token
  Future<void> saveToken(TokenEntity token) async {
    print('Token kaydediliyor: ${token.accessToken}');
    await _storage.write(key: _apiTokenKey, value: jsonEncode(token.toJson()));
    print('Token başarıyla kaydedildi');
  }

  //Remove token
  Future<void> removeToken() async {
    print('Token siliniyor');
    await _storage.delete(key: _apiTokenKey);
  }

  //Get token
  Future<TokenEntity?> getToken() async {
    try {
      print('Token getiriliyor...');
      final tokenEncoded = await _storage.read(key: _apiTokenKey);
      print('Raw token data: $tokenEncoded');
      if (tokenEncoded == null) {
        print('Token bulunamadı (null)');
        return null;
      }
      final token = TokenEntity.fromJson(
        jsonDecode(tokenEncoded) as Map<String, dynamic>,
      );
      print('Token başarıyla getirildi: ${token.accessToken}');
      return token;
    } catch (e) {
      print('Token getirme hatası: $e');
      return null;
    }
  }

  Future<void> logout() async {
    //todo: logout işlemleri yapılacak
  }
}
