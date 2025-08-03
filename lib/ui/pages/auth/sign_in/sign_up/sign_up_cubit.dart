import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/request/user/register/register_body.dart';
import 'package:my_app/models/token/token_entity.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/user/user_repository.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/sign_up_navigator.dart';
import 'package:my_app/ui/pages/auth/sign_in/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpNavigator navigator;
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final UserCubit userCubit;

  SignUpCubit({
    required this.navigator,
    required this.authRepo,
    required this.userRepo,
    required this.userCubit,
  }) : super(const SignUpState());

  void signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(
        state.copyWith(
          signUpStatus: LoadStatus.failure,
          errorMessage: 'Şifreler eşleşmiyor',
        ),
      );
      return;
    }

    emit(state.copyWith(signUpStatus: LoadStatus.loading));

    try {
      final registerBody = RegisterBody(
        email: email,
        name: name,
        password: password,
      );
      final response = await authRepo.signUp(registerBody);
      if (response.data.token.isNotEmpty) {
        final result = await authRepo.signIn(email, password);
        if (result != null) {
          userCubit.updateUser(result);
        }
        authRepo.saveToken(
          TokenEntity(
            accessToken: response.data.token,
            refreshToken: response.data.token,
          ),
        );
      }
      emit(state.copyWith(signUpStatus: LoadStatus.success));
      navigator.showSuccessFlushbar(message: 'Kayıt başarılı!');
      navigator.navigateToHome();
    } catch (e) {
      emit(
        state.copyWith(
          signUpStatus: LoadStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      navigator.showErrorFlushbar(message: e.toString());
    }
  }

  void resetState() {
    emit(const SignUpState());
  }
}
