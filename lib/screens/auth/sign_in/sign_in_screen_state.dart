part of 'sign_in_screen_cubit.dart';

@immutable
sealed class SignInScreenState {}

final class SignInScreenInitial extends SignInScreenState {}

final class SignInLoading extends SignInScreenState {}

final class SignInSuccess extends SignInScreenState {
  final String msg;

  SignInSuccess(this.msg);
}

final class SignInFailed extends SignInScreenState {
  final String msg;

  SignInFailed(this.msg);
}

final class SignInError extends SignInScreenState {
  final String msg;

  SignInError(this.msg);
}
