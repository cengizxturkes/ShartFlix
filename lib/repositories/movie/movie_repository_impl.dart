import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/network/api_client/api_client.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  ApiClient apiClient;

  MovieRepositoryImpl({required this.apiClient});

  @override
  Future<ListMoviesResponse> getMovies(int page) async {
    final response = await apiClient.getMovies(page);
    return response;
  }

  @override
  Future<FavoriteMovies> setMovieFavorite(String favoriteId) async {
    final response = await apiClient.setMovieFavorite(favoriteId);
    return response;
  }
}
