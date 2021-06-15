part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoadingUserDetails extends UserState {}

class UserDetailsSuccess extends UserState {
  final User user;

  UserDetailsSuccess({this.user});
}

class UserDetailsFailure extends UserState {
  final Exception exception;

  UserDetailsFailure({this.exception});
}
class UserStateInitial extends UserState {}
