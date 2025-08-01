import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/global_bloc/user/user_cubit.dart';
import 'package:my_app/logger/logger.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';
import 'package:my_app/models/token/token_entity.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/user/user_repository.dart';

import 'sign_in_navigator.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInNavigator navigator;
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final UserCubit userCubit;

  SignInCubit({
    required this.navigator,
    required this.authRepo,
    required this.userRepo,
    required this.userCubit,
  }) : super(const SignInState());

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void signIn() async {
    final email = state.email ?? '';
    final password = state.password ?? '';
    if (email.isEmpty) {
      navigator.showErrorFlushbar(message: 'Email boş olamaz');
      return;
    }
    if (password.isEmpty) {
      navigator.showErrorFlushbar(message: 'Şifre boş olamaz');
      return;
    }
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      final result = await authRepo.signIn(email, password);
      if (result != null) {
        userCubit.updateUser(result);
        authRepo.saveToken(
          TokenEntity(
            accessToken: result.data.token,
            refreshToken: result.data.token,
          ),
        );

        emit(state.copyWith(signInStatus: LoadStatus.success));
        navigator.openHomePage();
      } else {
        emit(state.copyWith(signInStatus: LoadStatus.initial));
      }
    } catch (error) {
      logger.e(error);
      navigator.showErrorFlushbar(
        message: 'Giriş yapılamadı, kullanıcı adı veya şifre hatalı',
      );
      emit(state.copyWith(signInStatus: LoadStatus.initial));
    }
  }
}
