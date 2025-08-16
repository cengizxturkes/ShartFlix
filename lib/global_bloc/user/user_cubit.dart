import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/models/response/user/login/google_sign_in_response.dart';
import 'package:my_app/repositories/user/user_repository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(const UserState());

  void updateUser(LoginResponse loginResponse) {
    if (isClosed) return;
    emit(state.copyWith(loginResponse: loginResponse));
  }

  void updateUserFromGoogleSignIn(GoogleSignInResponse googleSignInResponse) {
    if (isClosed) return;
    
    // Convert GoogleSignInResponse to LoginResponse format
    final loginResponse = LoginResponse(
      response: Response(
        code: googleSignInResponse.response.code,
        message: googleSignInResponse.response.message,
      ),
      data: Data(
        id: googleSignInResponse.data.id,
        dataId: googleSignInResponse.data.dataId,
        name: googleSignInResponse.data.name,
        email: googleSignInResponse.data.email,
        photoUrl: googleSignInResponse.data.photoUrl,
        token: googleSignInResponse.data.token,
      ),
    );
    
    emit(state.copyWith(loginResponse: loginResponse));
  }
}
