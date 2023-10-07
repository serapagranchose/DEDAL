import 'package:dedal/core/models/filter.dart';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

abstract class FilterDataSource extends BaseDataSource {
  Future<List<Filter>?> getAll(String token);
  Future<void> setinfoUser(User user);
}
