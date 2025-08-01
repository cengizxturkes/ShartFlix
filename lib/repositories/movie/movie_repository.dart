import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

abstract class MovieRepository {
  Future<ListMoviesResponse> getMovies(int page);
  Future<FavoriteMovies> setMovieFavorite(String favoriteId);
}
