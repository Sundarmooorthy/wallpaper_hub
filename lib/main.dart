import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_hub/firebase_options.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'screens/home_screen/home_screen_cubit.dart';
import 'screens/on_boarding/on_boarding_dart_cubit.dart';
import 'routes/routes.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ConfigManager.setUpRemoteConfig();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HomeRepository()),
        RepositoryProvider(create: (context) => SearchRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: route.AppRoute.controller,
        title: 'WallPaper Zone',
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: GoogleFonts.playfairDisplay().fontFamily,
        ),
        home: EntryPoint(),
      ),
    );
  }
}

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  bool isOnBoardingDone = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkViewsStatus();
  }

  Future<void> _checkViewsStatus() async {
    isOnBoardingDone = await AppStorage.isOnBoardingDone();
    isLoggedIn = await AppStorage.isLoggedIn();
    debugPrint("Is OnBoarding Done ? <<<<<<<$isOnBoardingDone");
    debugPrint("Is LoggedIn Done ? <<<<<<<$isLoggedIn");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isOnBoardingDone == false) {
      return BlocProvider(
        create: (context) => OnBoardingDartCubit(),
        child: OnboardingScreen(),
      );
    }

    if (isLoggedIn == true) {
      return BlocProvider(
        create: (context) => HomeScreenCubit(
          HomeRepository(),
        ),
        child: HomeScreen(),
      );
    }
    if (ConfigManager.instance.getMaintenanceStatus()) {
      debugPrint(
          "Maintenance Status ${ConfigManager.instance.getMaintenanceStatus()}");
      return UnderMaintenanceScreen();
    }

    return BlocProvider(
      create: (context) => SignInScreenCubit(),
      child: SignInScreen(),
    );
  }
}
