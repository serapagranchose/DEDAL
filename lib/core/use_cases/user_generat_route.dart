import 'dart:async';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
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
    final getPlaceResult = await Result.tryCatchAsync(
      () => filterDataSource.getPlaces(params!),
      (error) =>
          error is AppException ? error : ServerException(error.toString()),
    ).fold((value) => value, (error) => null);
    if (getPlaceResult.isNotNull && getPlaceResult!.isNotEmpty) {
      params?.places = getPlaceResult;
      final getPathResult = await Result.tryCatchAsync(
        () => filterDataSource.getPath(params!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()),
      ).fold((value) => value, (error) => null);

      if (getPathResult.isNotNull) {
        params?.info?.mapName = getPathResult;
        await Result.tryCatchAsync(
          () => filterDataSource.getMap(params!),
          (error) =>
              error is AppException ? error : ServerException(error.toString()),
        ).fold((value) => value, (error) => null);

        return const Ok(true);
      }
    }
    return const Ok(false);
  }
}
