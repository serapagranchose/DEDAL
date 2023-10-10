import 'dart:async';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UserGetPath extends AsyncUseCase<User, String?> {
  UserGetPath({
    required this.filterDataSource,
  });

  FilterDataSource filterDataSource;

  @override
  FutureOr<void> onStart(User? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<String?> execute(User? params) async => Result.tryCatchAsync(
      () => filterDataSource.getPath(params!),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));


  //     if (getPathResult.isNotNull) {
  //       print('4');

  //       params?.info?.mapName = getPathResult;
  //       await Result.tryCatchAsync(
  //         () => filterDataSource.getMap(params!),
  //         (error) =>
  //             error is AppException ? error : ServerException(error.toString()),
  //       ).fold((value) => value, (error) => null);
  //       print('true');

  //       return const Ok(true);
  //     }
  //   }
  //   print('false');
  //   return const Ok(false);
  // }
}
