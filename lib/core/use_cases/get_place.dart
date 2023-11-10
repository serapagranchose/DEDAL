import 'dart:async';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/place.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetPlace extends AsyncUseCase<String?, Place?> {
  GetPlace({
    required this.filterDataSource,
  });

  final FilterDataSource filterDataSource;

  @override
  FutureOr<void> onStart(String? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<Place?> execute(String? params) {
    return Result.tryCatchAsync(
        () => filterDataSource.getPlace(params!),
        (error) =>
            error is AppException ? error : ServerException(error.toString()));
  }
}
