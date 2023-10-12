import 'dart:async';

import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SetCredential extends AsyncUseCase<SigninDto?, NoParam> {
  SetCredential({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOr<void> onStart(SigninDto? params) {
    if (params == null || params.email == null || params.password == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<NoParam> execute(SigninDto? params) async =>
      Result.tryCatchAsync(
          () => localStorageDataSource
              .setCredential(params!)
              .then((value) => const NoParam()),
          (error) => error is AppException
              ? error
              : ServerException(error.toString()));
}
