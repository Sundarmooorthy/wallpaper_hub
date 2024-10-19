import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_hub/firebase_options.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/repository/repository.dart';

import 'screens/home_screen/home_screen_cubit.dart';
import 'screens/on_boarding/on_boarding_dart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ConfigManager.setUpRemoteConfig();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _checkViewsStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HomeRepository()),
        RepositoryProvider(create: (context) => SearchRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WallPaper Zone',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: GoogleFonts.playfairDisplay().fontFamily,
        ),
        home: showViewState(),
      ),
    );
  }

  bool isOnBoardingDone = false;

  bool isLoggedIn = false;

  Future<void> _checkViewsStatus() async {
    isOnBoardingDone = await AppStorage.isOnBoardingDone();
    isLoggedIn = await AppStorage.isLoggedIn();
    debugPrint("Is OnBoarding Done ? <<<<<<<$isOnBoardingDone");
    debugPrint("Is LoggedIn Done ? <<<<<<<$isLoggedIn");
    setState(() {});
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
