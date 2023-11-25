import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/constants/colors.dart';
import 'package:dedal/core/pages/api_offline_page.dart';
import 'package:dedal/core/pages/authentification/authentification_cubit.dart';
import 'package:dedal/core/pages/authentification/authentification_state.dart';
import 'package:dedal/core/pages/home/home_screen.dart';
import 'package:dedal/core/pages/home/onboarding_tooltip_wrapper.dart';
import 'package:dedal/core/pages/login/main.dart';
import 'package:dedal/core/router.dart';
import 'package:dedal/core/use_cases/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.settingsController,
  });

  final _navigatorKey = GlobalKey<NavigatorState>();
  late final GoRouter _router = AppRouter.router(_navigatorKey);
  final SettingsController settingsController;
  static BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  Widget build(BuildContext context) {
    ImageHelper.getBytesFromAsset('assets/logo/pin.png', 64)
        .then((value) => markerIcon = BitmapDescriptor.fromBytes(value));
    return AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.system, // Set the initial theme mode
        builder: (theme, darkTheme) {
          // Glue the SettingsController to the MaterialApp.
          //
          // The ListenableBuilder Widget listens to the SettingsController for changes.
          // Whenever the user updates their settings, the MaterialApp is rebuilt.
          return ListenableBuilder(
            listenable: settingsController,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp.router(
                routerConfig: _router,
                // Providing a restorationScopeId allows the Navigator built by the
                // MaterialApp to restore the navigation stack when a user leaves and
                // returns to the app after it has been killed while running in the
                // background.
                restorationScopeId: 'app',

                // Provide the generated AppLocalizations to the MaterialApp. This
                // allows descendant Widgets to display the correct translations
                // depending on the user's locale.
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('fr', ''),
                ],
                onGenerateTitle: (BuildContext context) => 'Dedal',

                // Define a light and dark color theme. Then, read the user's
                // preferred ThemeMode (light, dark, or system default) from the
                // SettingsController to display the correct theme.
                theme: theme,
                darkTheme: darkTheme,
                themeMode: settingsController.themeMode,
                builder: (context, child) => OnboardingToolTipWrapper(
                  child: AppViewContent(_navigatorKey, child),
                ),

                // Define a function to handle named routes in order to support
                // Flutter web url navigation and deep linking.
              );
            },
          );
        });
  }
}

class AppViewContent extends StatefulWidget {
  const AppViewContent(this._navigatorKey, this.child, {super.key});
  final GlobalKey<NavigatorState> _navigatorKey;
  NavigatorState get _navigator => _navigatorKey.currentState!;
  final Widget? child;

  @override
  State<AppViewContent> createState() => _AppViewContentState();
}

class _AppViewContentState extends State<AppViewContent> {
  @override
  Widget build(BuildContext context) => AppSafeContent(widget);
}

// ignore: must_be_immutable
class AppSafeContent extends StatelessWidget {
  AppSafeContent(this.widget, {super.key});
  AppViewContent widget;

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              widget._navigator.context.goNamed(HomeScreen.name);

              break;
            case AuthenticationStatus.unauthenticated:
              widget._navigator.context.goNamed(Main.routeName);
              break;
            case AuthenticationStatus.apiOffline:
              showDialog<void>(
                context: widget._navigator.context,
                builder: (_) => const APIOfflinePage(),
              );
              break;

            case AuthenticationStatus.unknown:
              widget._navigator.context.goNamed(Main.routeName);
              break;
            case AuthenticationStatus.loggingIn:
              break;
          }
        },
        child: widget.child,
      );
}
