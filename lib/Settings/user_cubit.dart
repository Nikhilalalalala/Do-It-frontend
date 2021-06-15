import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:doit/Service/UserRepository.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final userRepository = UserRepository();
  UserCubit() : super(LoadingUserDetails());

  void getUserDetails() async {
    if (state is UserDetailsSuccess == false) {
      emit(LoadingUserDetails());
    }

    try {
      final user = await userRepository.getUserDetails();
      emit(UserDetailsSuccess(user: user));
    } catch (e) {
      emit(UserDetailsFailure(exception: e));
    }
  }

  void updateUserBio(String newBio) async {
    userRepository.updateUserBio(newBio);
    getUserDetails();
  }

}
