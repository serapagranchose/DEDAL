import 'dart:async';

import 'package:dedal/core/datasources/filters/filters_datasource.dart';
import 'package:dedal/core/models/filter.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetFilters extends AsyncUseCase<String, List<Filter>?> {
  GetFilters({
    required this.filterDataSource,
  });

  FilterDataSource filterDataSource;

  @override
  FutureOr<void> onStart(String? params) {
    if (params == null) {
      throw const ClientException('params not valid');
    }
  }

  @override
  FutureOrResult<List<Filter>?> execute(String? params) => Result.tryCatchAsync(
      () => filterDataSource.getAll(params!),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
