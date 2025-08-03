import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart'; // loader_overlay import et
import 'package:my_app/database/secure_storage_helper.dart';
import 'package:my_app/logger/logger.dart';
import 'package:my_app/network/api_util/api_util.dart';
import 'package:my_app/router/route_config.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final context = AppRouter.navigationKey.currentContext;

    // Loader göster
    context?.loaderOverlay.show();

    final token = await SecureStorageHelper.instance.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer ${token.accessToken}';
      logger.i('🔐 Adding auth token to ${options.method} ${options.path}');
      logger.i('🔑 Token: ${token.accessToken.substring(0, 20)}...');
    } else {
      logger.w('⚠️ No token found for ${options.method} ${options.path}');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final context = AppRouter.navigationKey.currentContext;

    // İstek başarılı bitince loader gizle
    context?.loaderOverlay.hide();

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final context = AppRouter.navigationKey.currentContext;

    // Hata alındığında da loader gizle
    context?.loaderOverlay.hide();

    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;
    final uri = err.requestOptions.uri;
    final RequestOptions request = err.requestOptions;
    logger.e(
      "⚠️ ERROR[$statusCode] => PATH: $path \n Response: ${err.response?.data}",
    );
    switch (statusCode) {
      case 401:
        final savedToken = await SecureStorageHelper.instance.getToken();
        String requestingTokens = err.requestOptions.headers['Authorization']
            .toString()
            .replaceFirst("Bearer ", "");
        if (savedToken != null && savedToken.accessToken != requestingTokens) {
          final cloneReq = await _cloneRequest(
            accessToken: savedToken.accessToken,
            request: request,
            uri: uri,
          );
          return handler.resolve(cloneReq);
        }
        if (savedToken == null) {
          return handler.next(err);
        }
        try {
          final result = await ApiUtil.onRefreshToken(savedToken.accessToken);
          if (result != null) {
            SecureStorageHelper.instance.saveToken(result);
            final cloneReq = await _cloneRequest(
              accessToken: result.accessToken,
              request: request,
              uri: uri,
            );
            return handler.resolve(cloneReq);
          } else {
            logger.e("Response refresh token is null");
            _forceSignIn();
            return handler.next(err);
          }
        } catch (e) {
          logger.e(
            "Api refresh token error $e, msg: ${(e as DioException).response}",
          );
          _forceSignIn();
          return handler.next(err);
        }
      default:
        handler.next(err);
    }
  }

  Future<Response> _cloneRequest({
    required String accessToken,
    required RequestOptions request,
    required Uri uri,
  }) async {
    final newOptions = Options(
      method: request.method,
      headers: request.headers,
    );
    newOptions.headers!['Authorization'] = 'Bearer $accessToken';
    return await ApiUtil.getDio().requestUri(
      uri,
      options: newOptions,
      data: request.data,
    );
  }

  void _forceSignIn() {
    SecureStorageHelper.instance.removeToken();

    final context = AppRouter.navigationKey.currentContext;
    if (context == null) return;

    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).pushReplacementNamed(AppRouter.home);
  }
}
