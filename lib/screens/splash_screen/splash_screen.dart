import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import '../../repository/repository.dart';
import '../home_screen/home_screen_cubit.dart';
import '../on_boarding/on_boarding_dart_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isOnBoardingDone = false;
  bool isLoggedIn = false;

  Future<void> _checkViewsStatus() async {
    isOnBoardingDone = await AppStorage.isOnBoardingDone();
    isLoggedIn = await AppStorage.isLoggedIn();
    debugPrint("Is OnBoarding Done ? <<<<<<<$isOnBoardingDone");
    debugPrint("Is LoggedIn Done ? <<<<<<<$isLoggedIn");
    setState(() {});
  }

  void handleTimeout() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => showViewState()));
  }

  startTimeout() {
    var duration = const Duration(seconds: 3);
    return Future.delayed(duration, handleTimeout);
  }

  @override
  void initState() {
    super.initState();
    _checkViewsStatus();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppImages.splashImage,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget showViewState() {
    if (isOnBoardingDone == false) {
      return BlocProvider(
        create: (context) => OnBoardingDartCubit(),
        child: OnboardingScreen(),
      );
    }

    if (isLoggedIn == true) {
      return BlocProvider(
        create: (context) => HomeScreenCubit(HomeRepository()),
        child: HomeScreen(),
      );
    }

    return BlocProvider(
      create: (context) => SignInScreenCubit(),
      child: SignInScreen(),
    );
  }
}
