import 'dart:async';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UserGetMap extends AsyncUseCase<User, Map<String, Object>?> {
  UserGetMap({
    required this.filterDataSource,
  });

  final FilterDataSource filterDataSource;

  @override
  FutureOr<void> onStart(User? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<Map<String, Object>?> execute(User? params) {
    return Result.tryCatchAsync(
        () => filterDataSource.getMap(params!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()));
  }
}
