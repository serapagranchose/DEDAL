import 'dart:async';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/datasources/locations/locations_datasource.dart';
import 'package:dedal/core/models/place.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class LocationGetLists
    extends AsyncUseCase<User, (List<Place>?, List<Place>?, List<Place>?)> {
  LocationGetLists({
    required this.filterDataSource,
    required this.locationsDataSource,
  });

  FilterDataSource filterDataSource;
  LocationsDataSource locationsDataSource;

  @override
  FutureOr<void> onStart(User? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<(List<Place>?, List<Place>?, List<Place>?)> execute(
          User? params) async =>
      Result.tryCatchAsync(() async {
        final userPlace =
            params?.places ?? await filterDataSource.getPlaces(params!);
        final placeNear = await locationsDataSource.getPlaceClose(params!);
        final placeNoFilter = await locationsDataSource.getPlaceFilter(params);
        return ((userPlace, placeNear, placeNoFilter));
      },
          (error) => error is AppException
              ? error
              : ServerException(error.toString()));
}
