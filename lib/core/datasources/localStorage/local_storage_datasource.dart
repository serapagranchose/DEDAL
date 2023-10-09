import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

abstract class LocalStorageDataSource extends BaseDataSource {
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<void> clearUser();
}
