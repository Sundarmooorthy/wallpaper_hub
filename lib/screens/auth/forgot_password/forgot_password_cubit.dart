import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../my_app_exports.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> forgotPassword(String email, BuildContext context) async {
    emit(ForgotPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgotPasswordSuccess("Reset Password Link Sent To The Mail"));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Reset Password Link Sent To The Mail',
          style: TextStyle(color: Colors.white),
        ),
      ));
      Future.delayed(
        Duration(
          microseconds: 500,
        ),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SignInScreenCubit(),
                child: SignInScreen(),
              ),
            )),
      );
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
      emit(ForgotPasswordFailed(err.message.toString()));
    } catch (err) {
      throw Exception(err.toString());
      emit(ForgotPasswordError(err.toString()));
    }
  }
}
