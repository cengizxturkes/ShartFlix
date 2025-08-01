part of 'user_cubit.dart';

class UserState extends Equatable {
  final LoginResponse? loginResponse;
  final LoadStatus fetchUserStatus;

  const UserState({
    this.loginResponse,
    this.fetchUserStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [loginResponse, fetchUserStatus];

  UserState copyWith({
    LoginResponse? loginResponse,
    LoadStatus? fetchUserStatus,
  }) {
    return UserState(
      loginResponse: loginResponse ?? this.loginResponse,
      fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
    );
  }
}
