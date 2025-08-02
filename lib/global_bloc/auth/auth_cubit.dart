import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logger/logger.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo;

  AuthCubit({required this.authRepo}) : super(const AuthState());

  ///Sign Out
  Future<void> signOut() async {
    if (isClosed) return;
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (isClosed) return;

      await authRepo.removeToken();
      if (isClosed) return;

      emit(state.copyWith(signOutStatus: LoadStatus.success));
    } catch (e) {
      if (isClosed) return;
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }

  Future<void> deleteAccount() async {
    //Todo
  }
}
