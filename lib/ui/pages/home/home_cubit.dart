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
      emit(
        state.copyWith(movies: movies, fetchMovieStatus: LoadStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(fetchMovieStatus: LoadStatus.failure));
    }
  }
}
