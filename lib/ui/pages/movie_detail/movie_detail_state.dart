part of 'movie_detail_cubit.dart';

class MovieDetailState {
  final bool isFavorite;

  MovieDetailState({required this.isFavorite});

  factory MovieDetailState.initial() => MovieDetailState(isFavorite: false);

  MovieDetailState copyWith({bool? isFavorite}) {
    return MovieDetailState(
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
} 