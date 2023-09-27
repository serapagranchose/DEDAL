import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/authentification/authentification_cubit.dart';
import 'package:dedal/src/app.dart';
import 'package:dedal/src/settings/settings_controller.dart';
import 'package:dedal/src/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  await GetItInitializer.run();
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
                  loginDataSource: getIt<LoginDataSource>(),
                ))
      ],
      child: SafeArea(child: MyApp(settingsController: settingsController)),
    ),
  );
}
