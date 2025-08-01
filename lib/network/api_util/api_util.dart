import 'package:dio/dio.dart';
import 'package:my_app/configs/app_configs.dart';
import 'package:my_app/models/token/token_entity.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/network/api_interceptors/api_interceptors.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiUtil {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = const Duration(milliseconds: 60000);
      dio!.interceptors.add(ApiInterceptors());
      dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          compact: false,
        ),
      );
    }
    return dio!;
  }

  static ApiClient get apiClient {
    final apiClient = ApiClient(getDio(), baseUrl: AppConfigs.baseUrl);
    return apiClient;
  }

  static Future<TokenEntity?> onRefreshToken(String? token) async {
    if (token == null) return null;
    final dio = Dio();
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.headers['Authorization'] = "Bearer $token";
    dio.options.headers['connection'] = "keep-alive";
    dio.interceptors.add(PrettyDioLogger());
    final res = await dio.get('${AppConfigs.baseUrl}/refresh-token');
    final value = res.data == null ? null : TokenEntity.fromJson(res.data!);
    if (value != null) {
      return value;
    }
    return null;
  }
}
