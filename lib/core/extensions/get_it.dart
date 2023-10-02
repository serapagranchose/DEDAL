import 'package:dedal/core/datasources/authentification/login_datasource_impl.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/filters/filters_datasource_impl.dart';
import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

abstract class GetItInitializer {
  static Future<void> _init() async {
    // ignore: avoid_single_cascade_in_expression_statements
    getIt
      ..registerLazySingleton<LoginDataSource>(LoginDataSourceImpl.new)
      ..registerLazySingleton<FilterDataSource>(FilterDataSourceImpl.new)
      ..registerLazySingleton<LocalStorageDataSource>(
          LocalStorageDataSource.new);
  }

  static Future<void> run() async {
    await _init();
    await getIt.allReady();
  }
}
