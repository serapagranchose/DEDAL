import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetFirstStep extends AsyncUseCase<NoParam, bool?> {
  GetFirstStep({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOrResult<bool?> execute(NoParam? params) => Result.tryCatchAsync(
      () => localStorageDataSource.getFirstStep(),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
