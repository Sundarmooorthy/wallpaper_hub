import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_hub/screens/auth/forgot_password/forgot_password_cubit.dart';
import 'package:wallpaper_hub/screens/category_screen/category_screen_cubit.dart';
import 'package:wallpaper_hub/screens/home_screen/home_screen_cubit.dart';
import 'package:wallpaper_hub/screens/image_full_screen/image_full_screen_cubit.dart';
import 'package:wallpaper_hub/screens/on_boarding/on_boarding_dart_cubit.dart';
import 'package:wallpaper_hub/screens/search_screen/search_screen_cubit.dart';
import '../my_app_exports.dart';

class AppRoute {
  // #region app routes names

  static const String splashScreenScreen = '/splashScreenScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String signInScreen = '/signInScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String homeScreen = '/homeScreen';
  static const String categoryScreen = '/categoryScreen';
  static const String imageFullScreen = '/imageFullScreen';
  static const String searchScreen = '/searchScreen';

  // #endregion

  static Route<dynamic> controller(RouteSettings settings) {
    final args = settings.arguments;

    // You can create a helper function to resolve any type T from the context if needed
    T instanceOf<T>(BuildContext context) {
      return RepositoryProvider.of<T>(context);
    }

    switch (settings.name) {
      case AppRoute.splashScreenScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );

      case AppRoute.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnBoardingDartCubit(),
            child: OnboardingScreen(),
          ),
          settings: settings,
        );

      case AppRoute.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignUpScreenCubit(),
            child: SignUpScreen(),
          ),
          settings: settings,
        );

      case AppRoute.signInScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInScreenCubit(),
            child: SignInScreen(),
          ),
          settings: settings,
        );

      case AppRoute.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: ForgotPassword(),
          ),
          settings: settings,
        );

      case AppRoute.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeScreenCubit(
              instanceOf<HomeRepository>(context),
            ),
            child: HomeScreen(),
          ),
          settings: settings,
        );

      case AppRoute.categoryScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoryScreenCubit(
              instanceOf<SearchRepository>(context),
            ),
            child: CategoryScreen(
              args: args as CategoryScreenArgs,
            ),
          ),
          settings: settings,
        );

      case AppRoute.imageFullScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ImageFullScreenCubit(),
            child: ImageFullScreen(
              args: args as ImageFullScreenArgs,
            ),
          ),
          settings: settings,
        );

      case AppRoute.searchScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SearchScreenCubit(
              instanceOf<SearchRepository>(context),
            ),
            child: SearchScreen(),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
                child: Text('No Page Found With This Name ${settings.name}')),
          ),
        );
    }
  }
}
