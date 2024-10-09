import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../my_app_exports.dart';

class AppRoute {
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'categoryScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const CategoryScreen(image: '', categoryName: '');
            },
          ),
        ],
      ),
    ],
  );
}
