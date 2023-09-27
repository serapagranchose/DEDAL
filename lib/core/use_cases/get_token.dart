import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetToken extends AsyncUseCase<NoParam, String> {
  GetToken({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOrResult<String> execute(NoParam? params) => Result.tryCatchAsync(
      () => localStorageDataSource.getToken(),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
