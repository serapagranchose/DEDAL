import 'dart:async';

import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationGetPlaceByFilter
    extends AsyncUseCase<(User?, String?)?, List<Place>?> {
  LocationGetPlaceByFilter({required this.locationsDataSource});
  LocationsDataSource locationsDataSource;

  @override
  FutureOr<void> onStart((User?, String?)? params) {
    if (params == null && params!.$1 != null && params.$2 != null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<List<Place>?> execute((User?, String?)? params) =>
      Result.tryCatchAsync(
          () => locationsDataSource.getPlaceByFilter(params!.$1!, params.$2!),
          (error) => error is AppException
              ? error
              : ServerException(error.toString()));
}
