import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/logger/logger.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository movieRepo;
  final AuthCubit authCubit;

  MovieDetailCubit({required this.movieRepo, required this.authCubit})
    : super(MovieDetailState.initial());

  void toggleFavorite(String movieId) async {
    try {
      emit(state.copyWith(isFavorite: !state.isFavorite));
      await movieRepo.setMovieFavorite(movieId);
    } catch (e) {
      logger.e('Error toggling favorite: $e');
      emit(state.copyWith(isFavorite: !state.isFavorite));
    }
  }

  void setFavoriteStatus(bool isFavorite) {
    emit(state.copyWith(isFavorite: isFavorite));
  }
}
