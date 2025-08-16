import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_app/models/request/user/login/login_body.dart';
import 'package:my_app/models/request/user/login/google_sign_in.dart';
import 'package:my_app/models/request/user/register/register_body.dart';
import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/favorites/set_favorite_response.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/login/google_sign_in_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/models/response/user/register/register_response.dart';
import 'package:my_app/models/response/user/upload_photo/upload_photo_response.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
  @POST("user/login")
  Future<LoginResponse> authLogin(@Body() LoginBody body);
  @POST("auth/google-login")
  Future<GoogleSignInResponse> googleLogin(@Body() GoogleSignInBody body);
  @GET("movie/list")
  Future<ListMoviesResponse> getMovies(@Query("page") int page);
  @POST("movie/favorite/{favoriteId}")
  Future<SetFavoriteResponse> setMovieFavorite(
    @Path("favoriteId") String favoriteId,
  );
  @GET("user/profile")
  Future<ProfileResponse> getProfile();
  @GET("movie/favorites")
  Future<FavoriteMovies> getFavoriteMovies();
  @MultiPart()
  @POST("user/upload_photo")
  Future<UploadPhotoResponse> uploadProfilePhoto(@Part() File file);
  @POST("user/register")
  Future<RegisterResponse> register(@Body() RegisterBody registerBody);
}
