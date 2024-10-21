import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';

part 'sign_in_screen_state.dart';

class SignInScreenCubit extends Cubit<SignInScreenState> {
  SignInScreenCubit() : super(SignInScreenInitial());

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    emit(SignInLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await AppStorage.setLoggedIn(true);
      emit(SignInSuccess("Logged In Successfully!"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'User Not Found For This E-mail !!!',
            style: TextStyle(color: Colors.black),
          ),
        ));
        emit(SignInFailed("Sign In Failed"));
      } else if (e.code == 'invalid-credential') {
        // Show snack bar for email already in use
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text('Wrong Password'),
        ));
        emit(SignInFailed("Sign In Failed !!!"));
      } else {
        emit(SignInError("Error: ${e.message}"));
      }
    } catch (e) {
      emit(SignInError("Something Went Wrong: $e"));
    }
  }
}
