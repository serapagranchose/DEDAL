import 'dart:async';

import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SetFirstStep extends AsyncUseCase<bool?, NoParam> {
  SetFirstStep({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOr<void> onStart(bool? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<NoParam> execute(bool? params) async => Result.tryCatchAsync(
      () => localStorageDataSource
          .setFirstStep(params!)
          .then((value) => const NoParam()),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
