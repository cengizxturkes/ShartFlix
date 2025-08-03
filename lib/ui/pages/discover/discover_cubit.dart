import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/logger/logger.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final MovieRepository movieRepo;
  final AuthCubit authCubit;

  DiscoverCubit({required this.movieRepo, required this.authCubit})
    : super(DiscoverState.initial());

  void fetchMovies() async {
    if (isClosed) return;
    emit(state.copyWith(fetchMovieStatus: LoadStatus.loading));
    try {
      final movies = await movieRepo.getMovies(1);
      if (isClosed) return;

      // Get favorite movies to filter them out
      final favoriteMovies = await movieRepo.getFavoriteMovies();
      final favoriteMovieIds = favoriteMovies.data.map((m) => m.id).toSet();

      // Filter out movies that are already favorited
      final filteredMovies =
          movies.data.movies
              .where((movie) => !favoriteMovieIds.contains(movie.id))
              .toList();

      final hasMoreData =
          movies.data.pagination.currentPage < movies.data.pagination.maxPage;

      emit(
        state.copyWith(
          movies: movies.copyWith(
            data: movies.data.copyWith(movies: filteredMovies),
          ),
          fetchMovieStatus: LoadStatus.success,
          currentPage: 1,
          hasMoreData: hasMoreData,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(fetchMovieStatus: LoadStatus.failure));
    }
  }

  void loadMoreMovies() async {
    if (isClosed ||
        !state.hasMoreData ||
        state.fetchMovieStatus == LoadStatus.loading)
      return;

    emit(state.copyWith(fetchMovieStatus: LoadStatus.loading));
    try {
      final nextPage = state.currentPage + 1;
      final movies = await movieRepo.getMovies(nextPage);
      if (isClosed) return;

      // Get favorite movies to filter them out
      final favoriteMovies = await movieRepo.getFavoriteMovies();
      final favoriteMovieIds = favoriteMovies.data.map((m) => m.id).toSet();

      // Filter out movies that are already favorited
      final filteredMovies =
          movies.data.movies
              .where((movie) => !favoriteMovieIds.contains(movie.id))
              .toList();

      final hasMoreData =
          movies.data.pagination.currentPage < movies.data.pagination.maxPage;

      final updatedMovies = state.movies?.data.movies ?? [];
      updatedMovies.addAll(filteredMovies);

      emit(
        state.copyWith(
          movies: state.movies?.copyWith(
            data: state.movies!.data.copyWith(movies: updatedMovies),
          ),
          fetchMovieStatus: LoadStatus.success,
          currentPage: nextPage,
          hasMoreData: hasMoreData,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(fetchMovieStatus: LoadStatus.failure));
    }
  }

  void likeMovie(String movieId) async {
    try {
      await movieRepo.setMovieFavorite(movieId);
      // Remove the liked movie from the list
      final updatedMovies =
          state.movies?.data.movies
              .where((movie) => movie.id != movieId)
              .toList() ??
          [];

      emit(
        state.copyWith(
          movies: state.movies?.copyWith(
            data: state.movies!.data.copyWith(movies: updatedMovies),
          ),
        ),
      );
    } catch (e) {
      logger.e('Error liking movie: $e');
    }
  }

  void dislikeMovie(String movieId) {
    // Remove the disliked movie from the list
    final updatedMovies =
        state.movies?.data.movies
            .where((movie) => movie.id != movieId)
            .toList() ??
        [];

    emit(
      state.copyWith(
        movies: state.movies?.copyWith(
          data: state.movies!.data.copyWith(movies: updatedMovies),
        ),
      ),
    );
  }

  bool get hasMoreMovies => state.movies?.data.movies.isNotEmpty == true;
}
