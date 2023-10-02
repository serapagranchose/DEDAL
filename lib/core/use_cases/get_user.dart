import 'package:dedal/core/datasources/local_storage_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetUser extends AsyncUseCase<NoParam, User?> {
  GetUser({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOrResult<User?> execute(NoParam? params) => Result.tryCatchAsync(
      () => localStorageDataSource.getUser(),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
