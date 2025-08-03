part of 'discover_cubit.dart';

class DiscoverState {
  final ListMoviesResponse? movies;
  final LoadStatus fetchMovieStatus;
  final int currentPage;
  final bool hasMoreData;

  DiscoverState({
    this.movies,
    required this.fetchMovieStatus,
    required this.currentPage,
    required this.hasMoreData,
  });

  factory DiscoverState.initial() => DiscoverState(
    movies: null,
    fetchMovieStatus: LoadStatus.initial,
    currentPage: 0,
    hasMoreData: false,
  );

  DiscoverState copyWith({
    ListMoviesResponse? movies,
    LoadStatus? fetchMovieStatus,
    int? currentPage,
    bool? hasMoreData,
  }) {
    return DiscoverState(
      movies: movies ?? this.movies,
      fetchMovieStatus: fetchMovieStatus ?? this.fetchMovieStatus,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}
