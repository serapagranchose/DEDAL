import 'package:dedal/core/pages/filters/filters_screen.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/locations/location_screen.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/pages/login/signin/signin_screen.dart';
import 'package:dedal/core/pages/login/signup/signup_screen.dart';
import 'package:dedal/core/pages/profil/profil_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  /// Default transition for all pages

  static GoRouter router(
    GlobalKey<NavigatorState>? navigatorKey,
  ) =>
      GoRouter(
        initialLocation: '/main',
        navigatorKey: navigatorKey,
        routes: [
          // Public
          GoRoute(
            name: Main.routeName,
            path: '/main',
            builder: (BuildContext context, GoRouterState state) {
              print(state);
              print(state.uri);
              print(state.pathParameters);
              print(state.uri.queryParameters);
              return Main();
            },
          ),
          GoRoute(
            name: SignInScreen.routeName,
            path: '/signin',
            builder: (BuildContext context, GoRouterState state) {
              return SignInScreen();
            },
          ),
          GoRoute(
            name: SignUpScreen.routeName,
            path: '/signup',
            builder: (BuildContext context, GoRouterState state) {
              return SignUpScreen();
            },
          ),
          GoRoute(
            name: HomeScreen.name,
            path: '/home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
          GoRoute(
            name: ProfilScreen.name,
            path: '/profil',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilScreen();
            },
          ),
          GoRoute(
            name: LocationScreen.name,
            path: '/location',
            builder: (BuildContext context, GoRouterState state) {
              return const LocationScreen();
            },
          ),
          GoRoute(
            name: FilterScreen.name,
            path: '/filters',
            builder: (BuildContext context, GoRouterState state) {
              return const FilterScreen();
            },
          )
        ],
      );
}
