import 'dart:async';

import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_crud_bloc/wyatt_crud_bloc.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class UserGenerateRoute extends AsyncUseCase<User, bool> {
  UserGenerateRoute({
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
  FutureOrResult<bool> execute(User? params) async {
    print('start');
    final getPlaceResult = await Result.tryCatchAsync(
      () => filterDataSource.getPlaces(params!),
      (error) =>
          error is AppException ? error : ServerException(error.toString()),
    ).fold((value) => value, (error) => null);
    print('1');
    if (getPlaceResult.isNotNull && getPlaceResult!.isNotEmpty) {
      print('2');
      params?.places = getPlaceResult;
      final getPathResult = await Result.tryCatchAsync(
        () => filterDataSource.getPath(params!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()),
      ).fold((value) => value, (error) => null);
      print('3');

      if (getPathResult.isNotNull) {
        print('4');

        params?.info?.mapName = getPathResult;
        await Result.tryCatchAsync(
          () => filterDataSource.getMap(params!),
          (error) =>
              error is AppException ? error : ServerException(error.toString()),
        ).fold((value) => value, (error) => null);
        print('true');

        return const Ok(true);
      }
    }
    print('false');
    return const Ok(false);
  }
}
