import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';

class SignUpState extends Equatable {
  final LoadStatus signUpStatus;
  final String? errorMessage;

  const SignUpState({
    this.signUpStatus = LoadStatus.initial,
    this.errorMessage,
  });

  SignUpState copyWith({LoadStatus? signUpStatus, String? errorMessage}) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [signUpStatus, errorMessage];
}
