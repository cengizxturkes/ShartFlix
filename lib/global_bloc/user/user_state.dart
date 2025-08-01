part of 'user_cubit.dart';

class UserState extends Equatable {
  final ProfileResponse? user;
  final LoadStatus fetchUserStatus;

  const UserState({this.user, this.fetchUserStatus = LoadStatus.initial});

  @override
  List<Object?> get props => [user, fetchUserStatus];

  UserState copyWith({ProfileResponse? user, LoadStatus? fetchUserStatus}) {
    return UserState(
      user: user ?? this.user,
      fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
    );
  }
}
