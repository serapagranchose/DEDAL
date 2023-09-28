import 'dart:async';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_up_dto.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignUpCode extends AsyncUseCase<SignUpDto, bool> {
  SignUpCode({
    required this.loginDataSource,
  });

  LoginDataSource loginDataSource;

  @override
  FutureOr<void> onStart(SignUpDto? params) {
    if (params == null || params.email == null || params.code == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<bool> execute(SignUpDto? params) {
    return Result.tryCatchAsync(
        () => loginDataSource.signUpCode(params!.email!, params.code!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()));
  }
}
