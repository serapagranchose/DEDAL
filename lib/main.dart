import 'dart:io';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/extensions/get_it.dart';
import 'package:dedal/core/pages/authentification/authentification_cubit.dart';
import 'package:dedal/src/app.dart';
import 'package:dedal/src/settings/settings_controller.dart';
import 'package:dedal/src/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  await GetItInitializer.run();
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      WidgetsFlutterBinding.ensureInitialized();
      try {
        mapsImplementation.initializeWithRenderer(AndroidMapRenderer.legacy);
      } catch (_) {}
    }
  }
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // Open your boxes. Optional: Give it a type.
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
                  loginDataSource: getIt<LoginDataSource>(),
                )..init()),
      ],
      child: SafeArea(child: MyApp(settingsController: settingsController)),
    ),
  );
}
