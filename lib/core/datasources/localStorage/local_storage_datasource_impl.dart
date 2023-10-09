import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:hive/hive.dart';

const _userBoxName = 'userBox';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  @override
  Future<User?> getUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    final user = box.get('user');
    print('user1 => $user');
    return user;
  }

  @override
  Future<void> saveUser(User user) async {
    final box = await Hive.openBox<User>(_userBoxName);
    print('in => $user');
    await box.put('user', user);
  }

  @override
  Future<void> clearUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    await box.delete('user');
  }
}
