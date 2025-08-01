import 'package:dio/dio.dart';
import 'package:my_app/models/request/user/login/login_body.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  @POST("user/login")
  Future<LoginResponse> authLogin(@Body() LoginBody body);
}
