import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../my_app_exports.dart';

part 'sign_up_screen_state.dart';

class SignUpScreenCubit extends Cubit<SignUpScreenState> {
  SignUpScreenCubit() : super(SignUpScreenInitial());

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    emit(SignUpLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(SignUpSuccess("User registered successfully!"));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Sign Up SuccessFull Please Log In.',
          style: TextStyle(color: Colors.white),
        ),
      ));
      Future.delayed(
        Duration(seconds: 1),
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => SignInScreenCubit(),
                  child: SignInScreen(),
                ),
              ));
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Your Password is Weak',
            style: TextStyle(color: Colors.black),
          ),
        ));

        emit(SignUpFailed("Your Password is Weak"));
      } else if (e.code == 'email-already-in-use') {
        // Show snack bar for email already in use
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text('Email Already Exist!'),
        ));

        emit(SignUpFailed("Email Already Exist!"));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          content: Text('Password did not match !!!'),
        ));
      } else {
        emit(SignUpError("Error: ${e.message}"));
      }
    } catch (e) {
      emit(SignUpError("Something Went Wrong: $e"));
    }
  }
}
