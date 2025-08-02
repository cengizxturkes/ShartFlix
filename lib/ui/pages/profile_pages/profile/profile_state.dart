import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';

class ProfileState extends Equatable {
  final LoadStatus fetchUserStatus;
  final int currentNavigationIndex;
  final String userProfileImage;
  final bool isDarkMode;
  final ProfileResponse? profileResponse;
  const ProfileState({
    this.fetchUserStatus = LoadStatus.initial,
    this.currentNavigationIndex = 1,
    this.userProfileImage = '',
    this.isDarkMode = false,
    this.profileResponse,
  });

  @override
  List<Object?> get props => [
    fetchUserStatus,
    currentNavigationIndex,

    userProfileImage,
    isDarkMode,
    profileResponse,
  ];

  ProfileState copyWith({
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
  }) {
    return ProfileState(
      fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
      currentNavigationIndex:
          currentNavigationIndex ?? this.currentNavigationIndex,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      profileResponse: profileResponse ?? this.profileResponse,
    );
  }
}
