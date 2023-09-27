import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:dedal/core/datasources/login_datasource.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

abstract class GetItInitializer {
  static Future<void> _init() async {
    // ignore: avoid_single_cascade_in_expression_statements
    getIt
      ..registerLazySingleton<LoginDataSource>(LoginDataSource.new)
      ..registerLazySingleton<LocalStorageDataSource>(
          LocalStorageDataSource.new);
  }

  static Future<void> run() async {
    await _init();
    await getIt.allReady();
  }
}
