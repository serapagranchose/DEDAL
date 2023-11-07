import 'dart:async';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UserUnsubscribe extends AsyncUseCase<User?, bool> {
  UserUnsubscribe({
    required this.loginDataSource,
  });

  LoginDataSource loginDataSource;

  @override
  FutureOr<void> onStart(User? params) {
    if (params == null || params.email == null || params.id == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<bool> execute(User? params) {
    return Result.tryCatchAsync(
        () => loginDataSource.unsubscribe(params!.id!, params.email!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()));
  }
}
