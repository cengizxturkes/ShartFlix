import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/user/login/login_response.dart';
import 'package:my_app/repositories/user/user_repository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(const UserState());

  void updateUser(LoginResponse loginResponse) {
    if (isClosed) return;
    emit(state.copyWith(loginResponse: loginResponse));
  }
}
