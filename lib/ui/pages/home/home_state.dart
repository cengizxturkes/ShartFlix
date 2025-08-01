import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

class HomeState extends Equatable {
  final LoadStatus fetchMovieStatus;
  final LoadStatus loadMoreStatus;
  final LoadStatus refreshStatus;
  final ListMoviesResponse? movies;
  final int currentPage;
  final bool hasMoreData;
  final int currentNavigationIndex;

  const HomeState({
    this.fetchMovieStatus = LoadStatus.initial,
    this.loadMoreStatus = LoadStatus.initial,
    this.refreshStatus = LoadStatus.initial,
    this.movies,
    this.currentPage = 1,
    this.hasMoreData = true,
    this.currentNavigationIndex = 0,
  });

  @override
  List<Object?> get props => [
    fetchMovieStatus,
    loadMoreStatus,
    refreshStatus,
    movies,
    currentPage,
    hasMoreData,
    currentNavigationIndex,
  ];

  HomeState copyWith({
    LoadStatus? fetchMovieStatus,
    LoadStatus? loadMoreStatus,
    LoadStatus? refreshStatus,
    ListMoviesResponse? movies,
    int? currentPage,
    bool? hasMoreData,
    int? currentNavigationIndex,
  }) {
    return HomeState(
      fetchMovieStatus: fetchMovieStatus ?? this.fetchMovieStatus,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentNavigationIndex:
          currentNavigationIndex ?? this.currentNavigationIndex,
    );
  }
}
