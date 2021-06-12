import 'package:bloc/bloc.dart';
import 'package:doit/Common/FormSubmissionStatus.dart';
import 'package:meta/meta.dart';
import 'package:doit/Service/AuthRepository.dart';
part 'create_new_user_state.dart';

class CreateNewUserCubit extends Cubit<CreateNewUserState> {
  CreateNewUserCubit() : super(CreateNewUserInitial());

  void createNewUser(String username, String email, String password,
      String confirmPassword) async {
    if (password != confirmPassword) {
      emit(CreateNewUserFailure(error: "Passwords don't match"));
    }
    String response = await AuthService.createNewUser(username.trim(),
        email.trim(), password);
    print(response);
    print(response.trim() == 'success');
    if (response.trim() == 'success') {
      emit(CreateNewUserSuccess());
    } else {
      emit(CreateNewUserFailure(error: "error"));
    }
  }
}
