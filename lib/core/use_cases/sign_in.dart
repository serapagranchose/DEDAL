import 'dart:async';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class SignIn extends AsyncUseCase<SigninDto, User?> {
  SignIn({
    required this.loginDataSource,
  });

  LoginDataSource loginDataSource;

  @override
  FutureOr<void> onStart(SigninDto? params) {
    if (params == null || params.email == null || params.password == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<User?> execute(SigninDto? params) {
    return Result.tryCatchAsync(
        () => loginDataSource.signIn(params!.email!, params.password!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()));
  }
}
