import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/home/home_navigator.dart';
import 'package:my_app/ui/pages/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final AuthRepository authRepo;
  final MovieRepository movieRepo;

  HomeCubit({
    required this.navigator,
    required this.authRepo,
    required this.movieRepo,
  }) : super(const HomeState());

  void fetchMovies() async {
    emit(state.copyWith(fetchMovieStatus: LoadStatus.loading));
    try {
      final movies = await movieRepo.getMovies(1);
      final hasMoreData =
          movies.data.pagination.currentPage < movies.data.pagination.maxPage;

      emit(
        state.copyWith(
          movies: movies,
          fetchMovieStatus: LoadStatus.success,
          currentPage: 1,
          hasMoreData: hasMoreData,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetchMovieStatus: LoadStatus.failure));
    }
  }

  void loadMoreMovies() async {
    if (!state.hasMoreData || state.loadMoreStatus == LoadStatus.loading) {
      return;
    }

    emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
    try {
      final nextPage = state.currentPage + 1;
      final newMovies = await movieRepo.getMovies(nextPage);

      if (newMovies.data.movies.isNotEmpty) {
        // Merge new movies with existing ones
        final updatedMovies = state.movies?.copyWith(
          data: state.movies!.data.copyWith(
            movies: [...state.movies!.data.movies, ...newMovies.data.movies],
            pagination: newMovies.data.pagination,
          ),
        );

        final hasMoreData =
            newMovies.data.pagination.currentPage <
            newMovies.data.pagination.maxPage;

        emit(
          state.copyWith(
            movies: updatedMovies,
            currentPage: nextPage,
            loadMoreStatus: LoadStatus.success,
            hasMoreData: hasMoreData,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loadMoreStatus: LoadStatus.success,
            hasMoreData: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }

  void refreshMovies() async {
    emit(state.copyWith(refreshStatus: LoadStatus.loading));
    try {
      final movies = await movieRepo.getMovies(1);
      final hasMoreData =
          movies.data.pagination.currentPage < movies.data.pagination.maxPage;

      emit(
        state.copyWith(
          movies: movies,
          refreshStatus: LoadStatus.success,
          currentPage: 1,
          hasMoreData: hasMoreData,
        ),
      );
    } catch (e) {
      emit(state.copyWith(refreshStatus: LoadStatus.failure));
    }
  }

  void setMovieFavorite(String favoriteId) async {
    final tempMovies = state.movies?.copyWith(
      data: state.movies!.data.copyWith(
        movies:
            state.movies!.data.movies.map((movie) {
              if (movie.id == favoriteId) {
                return movie.copyWith(isFavorite: !movie.isFavorite);
              }
              return movie;
            }).toList(),
      ),
    );
    emit(state.copyWith(movies: tempMovies));

    try {
      final response = await movieRepo.setMovieFavorite(favoriteId);
      if (response.response.code != 200) {
        // API hata verirse geri al
        emit(state.copyWith(movies: state.movies));
      }
    } catch (e) {
      // API hata verirse geri al
      emit(state.copyWith(movies: state.movies));
    }
  }

  void onNavigationChanged(int index) {
    emit(state.copyWith(currentNavigationIndex: index));

    // Handle navigation based on index
    switch (index) {
      case 0:
        // Home - already here, do nothing
        break;
      case 1:
        // Profile - navigate to profile page
        navigator.navigateToProfile();
        break;
      default:
        break;
    }
  }
}
