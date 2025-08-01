part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? email;
  final String? password;
  final String? error;
  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.email,
    this.password,
    this.error,
  });

  @override
  List<Object?> get props => [signInStatus, email, password, error];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? email,
    String? password,
    String? error,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }
}
