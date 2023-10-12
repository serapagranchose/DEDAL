import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:wyatt_type_utils/wyatt_type_utils.dart';

class GetCredential extends AsyncUseCase<NoParam, SigninDto?> {
  GetCredential({
    required this.localStorageDataSource,
  });

  LocalStorageDataSource localStorageDataSource;

  @override
  FutureOrResult<SigninDto?> execute(NoParam? params) => Result.tryCatchAsync(
      () => localStorageDataSource.getCredential(),
      (error) =>
          error is AppException ? error : ServerException(error.toString()));
}
