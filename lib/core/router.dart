import 'package:dedal/core/pages/filters/filters_screen.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/location_detail/location_place_detail_screen.dart';
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
  static Page<void> noTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        transitionsBuilder: (_, __, ___, child) => child,
        child: child,
      );
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
            pageBuilder: (context, state) =>
                noTransition(context, state, const Main()),
          ),
          GoRoute(
            name: SignInScreen.routeName,
            path: '/signin',
            pageBuilder: (context, state) =>
                noTransition(context, state, const SignInScreen()),
          ),
          GoRoute(
            name: SignUpScreen.routeName,
            path: '/signup',
            pageBuilder: (context, state) =>
                noTransition(context, state, const SignUpScreen()),
          ),
          GoRoute(
            name: HomeScreen.name,
            path: '/home',
            pageBuilder: (context, state) =>
                noTransition(context, state, const HomeScreen()),
          ),
          GoRoute(
            name: ProfileScreen.name,
            path: '/profile',
            pageBuilder: (context, state) =>
                noTransition(context, state, const ProfileScreen()),
          ),
          GoRoute(
            name: LocationScreen.name,
            path: '/location',
            pageBuilder: (context, state) =>
                noTransition(context, state, const LocationScreen()),
          ),
          GoRoute(
            name: FilterScreen.name,
            path: '/filters',
            pageBuilder: (context, state) =>
                noTransition(context, state, const FilterScreen()),
          ),
          GoRoute(
              name: LocationPlaceDetailScreen.name,
              path: '/place-detail',
              pageBuilder: (context, state) => noTransition(
                    context,
                    state,
                    LocationPlaceDetailScreen(
                      id: state.uri.queryParameters['id'],
                      placeName: state.uri.queryParameters['placeName'],
                    ),
                  ))
        ],
      );
}
