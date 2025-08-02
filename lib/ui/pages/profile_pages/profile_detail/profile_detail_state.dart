import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';

class ProfileDetailState extends Equatable {
  final LoadStatus fetchUserStatus;
  final int currentNavigationIndex;
  final String userProfileImage;
  final bool isDarkMode;
  final ProfileResponse? profileResponse;
  final FavoriteMovies? favoriteMovies;
  const ProfileDetailState({
    this.fetchUserStatus = LoadStatus.initial,
    this.currentNavigationIndex = 1,
    this.userProfileImage = '',
    this.isDarkMode = false,
    this.profileResponse,
    this.favoriteMovies,
  });

  @override
  List<Object?> get props => [
    fetchUserStatus,
    currentNavigationIndex,
    userProfileImage,
    isDarkMode,
    profileResponse,
    favoriteMovies,
  ];

  ProfileDetailState copyWith({
    LoadStatus? fetchUserStatus,
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
      fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
      currentNavigationIndex:
          currentNavigationIndex ?? this.currentNavigationIndex,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      profileResponse: profileResponse ?? this.profileResponse,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
    );
  }
}
