import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';

class ProfileDetailState extends Equatable {
  final LoadStatus fetchMovieStatus;
  final int currentNavigationIndex;
  final String userProfileImage;
  final bool isDarkMode;
  final ProfileResponse? profileResponse;
  final FavoriteMovies? favoriteMovies;
  const ProfileDetailState({
    this.fetchMovieStatus = LoadStatus.initial,
    this.currentNavigationIndex = 1,
    this.userProfileImage = '',
    this.isDarkMode = false,
    this.profileResponse,
    this.favoriteMovies,
  });

  @override
  List<Object?> get props => [
    fetchMovieStatus,
    currentNavigationIndex,
    userProfileImage,
    isDarkMode,
    profileResponse,
    favoriteMovies,
  ];

  ProfileDetailState copyWith({
    LoadStatus? fetchMovieStatus,
    LoadStatus? loadMoreStatus,
    LoadStatus? refreshStatus,
    ListMoviesResponse? movies,
    int? currentPage,
    bool? hasMoreData,
    int? currentNavigationIndex,
    String? userName,
    String? userEmail,
    String? userProfileImage,
    bool? isDarkMode,
    ProfileResponse? profileResponse,
    FavoriteMovies? favoriteMovies,
  }) {
    return ProfileDetailState(
      fetchMovieStatus: fetchMovieStatus ?? this.fetchMovieStatus,
      currentNavigationIndex:
          currentNavigationIndex ?? this.currentNavigationIndex,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      profileResponse: profileResponse ?? this.profileResponse,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
    );
  }
}
