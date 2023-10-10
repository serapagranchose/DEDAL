import 'dart:async';

import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UpdateUser extends AsyncUseCase<User?, NoParam> {
  UpdateUser({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOr<void> onStart(User? params) {
    print('params => $params');
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<NoParam> execute(User? params) async => Result.tryCatchAsync(
      () => localStorageDataSource
          .saveUser(params!)
          .then((value) => const NoParam()),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
