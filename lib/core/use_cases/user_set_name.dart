import 'dart:async';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';
import 'package:dedal/core/dtos/change_username_dto.dart';

class UserSetName extends AsyncUseCase<ChangeUsernameDto?, bool> {
  UserSetName({
    required this.filterDataSource,
  });

  FilterDataSource filterDataSource;

  @override
  FutureOr<void> onStart(ChangeUsernameDto? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<bool> execute(ChangeUsernameDto? params) async => Result.tryCatchAsync(
      () => filterDataSource.setUserName(params!),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
