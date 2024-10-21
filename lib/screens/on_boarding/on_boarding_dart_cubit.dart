import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../my_app_exports.dart';

part 'on_boarding_dart_state.dart';

class OnBoardingDartCubit extends Cubit<OnBoardingDartState> {
  OnBoardingDartCubit() : super(OnBoardingDartInitial());

  void handleOnPressed(
      BuildContext context, int currentPage, PageController controller) async {
    if (currentPage == 2) {
      bool isOnboardingDone = true;

      isOnboardingDone = true;

      await AppStorage.setOnBoardingDone(isOnboardingDone);
      debugPrint("Is On Boarding Done ? <<<<< $isOnboardingDone");
      replaceWith(context, AppRoute.signInScreen);
    } else {
      currentPage++;
      controller.nextPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.decelerate,
      );
    }
  }
}
