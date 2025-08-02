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
    if (isClosed) return;
    emit(state.copyWith(fetchMovieStatus: LoadStatus.loading));
    try {
      final movies = await movieRepo.getMovies(1);
      if (isClosed) return;

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
      if (isClosed) return;
      emit(state.copyWith(fetchMovieStatus: LoadStatus.failure));
    }
  }

  void loadMoreMovies() async {
    if (!state.hasMoreData || state.loadMoreStatus == LoadStatus.loading) {
      return;
    }

    if (isClosed) return;
    emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
    try {
      final nextPage = state.currentPage + 1;
      final newMovies = await movieRepo.getMovies(nextPage);
      if (isClosed) return;

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
      if (isClosed) return;
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }

  void refreshMovies() async {
    if (isClosed) return;
    emit(state.copyWith(refreshStatus: LoadStatus.loading));
    try {
      final movies = await movieRepo.getMovies(1);
      if (isClosed) return;

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
      if (isClosed) return;
      emit(state.copyWith(refreshStatus: LoadStatus.failure));
    }
  }

  void setMovieFavorite(String favoriteId) async {
    if (isClosed) return;
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
      if (isClosed) return;

      if (response.response.code != 200) {
        // API hata verirse geri al
        emit(state.copyWith(movies: state.movies));
      }
    } catch (e) {
      if (isClosed) return;
      // API hata verirse geri al
      emit(state.copyWith(movies: state.movies));
    }
  }

  void onNavigationChanged(int index) {
    if (isClosed) return;
    emit(state.copyWith(currentNavigationIndex: index));
  }

  void searchMovies(String query) {
    if (isClosed) return;

    if (query.trim().isEmpty) {
      // Arama temizlendiğinde orijinal listeyi göster
      emit(
        state.copyWith(
          filteredMovies: null,
          searchQuery: '',
          searchStatus: LoadStatus.initial,
        ),
      );
      return;
    }

    emit(state.copyWith(searchStatus: LoadStatus.loading, searchQuery: query));

    try {
      if (state.movies == null) {
        emit(state.copyWith(searchStatus: LoadStatus.failure));
        return;
      }

      final allMovies = state.movies!.data.movies;
      final filteredMoviesList =
          allMovies.where((movie) {
            final searchLower = query.toLowerCase();
            return movie.title.toLowerCase().contains(searchLower) ||
                movie.genre.toLowerCase().contains(searchLower) ||
                movie.director.toLowerCase().contains(searchLower) ||
                movie.actors.toLowerCase().contains(searchLower) ||
                movie.year.contains(searchLower) ||
                movie.plot.toLowerCase().contains(searchLower);
          }).toList();

      final filteredResponse = state.movies!.copyWith(
        data: state.movies!.data.copyWith(movies: filteredMoviesList),
      );

      emit(
        state.copyWith(
          filteredMovies: filteredResponse,
          searchStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(searchStatus: LoadStatus.failure));
    }
  }

  void clearSearch() {
    if (isClosed) return;
    emit(
      state.copyWith(
        filteredMovies: null,
        searchQuery: '',
        searchStatus: LoadStatus.initial,
      ),
    );
  }
}
