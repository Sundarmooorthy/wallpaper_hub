part of 'sign_up_screen_cubit.dart';

@immutable
sealed class SignUpScreenState {}

final class SignUpScreenInitial extends SignUpScreenState {}

final class SignUpLoading extends SignUpScreenState {}

final class SignUpSuccess extends SignUpScreenState {
  final String msg;

  SignUpSuccess(this.msg);
}

final class SignUpFailed extends SignUpScreenState {
  final String msg;

  SignUpFailed(this.msg);
}

final class SignUpError extends SignUpScreenState {
  final String msg;

  SignUpError(this.msg);
}
