import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/favorites/set_favorite_response.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

abstract class MovieRepository {
  Future<ListMoviesResponse> getMovies(int page);
  Future<SetFavoriteResponse> setMovieFavorite(String favoriteId);
  Future<FavoriteMovies> getFavoriteMovies();
}
