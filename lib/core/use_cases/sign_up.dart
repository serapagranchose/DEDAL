import 'dart:async';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignUp extends AsyncUseCase<SignUpDto, bool> {
  SignUp({
    required this.loginDataSource,
  });

  LoginDataSource loginDataSource;

  @override
  FutureOr<void> onStart(SignUpDto? params) {
    if (params == null || params.email == null || params.password == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<bool> execute(SignUpDto? params) {
    return Result.tryCatchAsync(
        () => loginDataSource.signUp(params!.email!, params.password!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()));
  }
}
