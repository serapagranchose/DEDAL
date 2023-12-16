import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/use_cases/tooltip_helper.dart';
import 'package:get_it/get_it.dart';

import 'datasources/authentification/login_datasource_impl.dart';
import 'datasources/filters/filters_datasource_impl.dart';
import 'datasources/locations/locations_datasource_impl.dart';

final getIt = GetIt.I;

abstract class GetItInitializerTest {
  static Future<void> _init() async {
    // ignore: avoid_single_cascade_in_expression_statements
    getIt
      ..registerLazySingleton<OnboardingTooTipHelper>(
        OnboardingTooTipHelper.new,
      )
      ..registerLazySingleton<LoginDataSource>(LoginDataSourceImplTest.new)
      ..registerLazySingleton<FilterDataSource>(FilterDataSourceImplTest.new)
      ..registerLazySingleton<LocationsDataSource>(
          LocationsDataSourceImplTest.new);
  }

  static Future<void> run() async {
    await _init();
    await getIt.allReady();
  }
}
