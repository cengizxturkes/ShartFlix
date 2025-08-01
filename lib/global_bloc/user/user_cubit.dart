import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/user/profile/profile_response.dart';

import 'package:my_app/repositories/user/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(const UserState());

  Future<void> fetchUser() async {
    if (state.fetchUserStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(fetchUserStatus: LoadStatus.loading));
    try {
      final user = await userRepository.getProfile();
      emit(state.copyWith(fetchUserStatus: LoadStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(fetchUserStatus: LoadStatus.failure));
    }
  }

  void updateUser(ProfileResponse user) {
    emit(state.copyWith(user: user));
  }
}
