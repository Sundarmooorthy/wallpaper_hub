import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/firebase_options.dart';
import 'package:wallpaper_hub/my_app_exports.dart';
import 'package:wallpaper_hub/repository/repository.dart';
import 'package:wallpaper_hub/screens/home_screen/home_screen_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ConfigManager.setUpRemoteConfig();
  runApp(const MyApp());
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
          title: 'WallPaper Zone',
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          home: BlocProvider(
            create: (context) => HomeScreenCubit(
              HomeRepository(),
            ),
            child: const HomeScreen(),
          )),
    );
  }
}
