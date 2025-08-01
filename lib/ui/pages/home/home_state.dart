import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

class HomeState extends Equatable {
  final LoadStatus fetchMovieStatus;
  final ListMoviesResponse? movies;
  const HomeState({this.fetchMovieStatus = LoadStatus.initial, this.movies});

  @override
  List<Object?> get props => [fetchMovieStatus, movies];

  HomeState copyWith({
    LoadStatus? fetchMovieStatus,
    ListMoviesResponse? movies,
  }) {
    return HomeState(
      fetchMovieStatus: fetchMovieStatus ?? this.fetchMovieStatus,
      movies: movies ?? this.movies,
    );
  }
}
