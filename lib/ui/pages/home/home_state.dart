import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

class HomeState extends Equatable {
  final LoadStatus fetchMovieStatus;
  final LoadStatus loadMoreStatus;
  final LoadStatus refreshStatus;
  final LoadStatus searchStatus;
  final ListMoviesResponse? movies;
  final ListMoviesResponse? filteredMovies;
  final String searchQuery;
  final int currentPage;
  final bool hasMoreData;
  final int currentNavigationIndex;

  const HomeState({
    this.fetchMovieStatus = LoadStatus.initial,
    this.loadMoreStatus = LoadStatus.initial,
    this.refreshStatus = LoadStatus.initial,
    this.searchStatus = LoadStatus.initial,
    this.movies,
    this.filteredMovies,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasMoreData = true,
    this.currentNavigationIndex = 0,
  });

  @override
  List<Object?> get props => [
    fetchMovieStatus,
    loadMoreStatus,
    refreshStatus,
    searchStatus,
    movies,
    filteredMovies,
    searchQuery,
    currentPage,
    hasMoreData,
    currentNavigationIndex,
  ];

  HomeState copyWith({
    LoadStatus? fetchMovieStatus,
    LoadStatus? loadMoreStatus,
    LoadStatus? refreshStatus,
    LoadStatus? searchStatus,
    ListMoviesResponse? movies,
    ListMoviesResponse? filteredMovies,
    String? searchQuery,
    int? currentPage,
    bool? hasMoreData,
    int? currentNavigationIndex,
  }) {
    return HomeState(
      fetchMovieStatus: fetchMovieStatus ?? this.fetchMovieStatus,
      loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      refreshStatus: refreshStatus ?? this.refreshStatus,
      searchStatus: searchStatus ?? this.searchStatus,
      movies: movies ?? this.movies,
      filteredMovies: filteredMovies ?? this.filteredMovies,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentNavigationIndex:
          currentNavigationIndex ?? this.currentNavigationIndex,
    );
  }
}
