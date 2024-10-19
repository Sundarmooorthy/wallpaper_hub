part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final String msg;

  ForgotPasswordSuccess(this.msg);
}

final class ForgotPasswordFailed extends ForgotPasswordState {
  final String msg;

  ForgotPasswordFailed(this.msg);
}

final class ForgotPasswordError extends ForgotPasswordState {
  final String msg;

  ForgotPasswordError(this.msg);
}
