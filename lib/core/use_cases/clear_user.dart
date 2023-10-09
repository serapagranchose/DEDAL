import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class ClearUser extends AsyncUseCase<NoParam, void> {
  ClearUser({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOrResult<void> execute(NoParam? params) => Result.tryCatchAsync(
      () => localStorageDataSource.clearUser(),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
