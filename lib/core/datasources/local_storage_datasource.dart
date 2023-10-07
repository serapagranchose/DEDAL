import 'package:dedal/core/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

class LocalStorageDataSource extends BaseDataSource {
  Future<void> setToken(String token) => GetStorage().write('token', token);
  Future<void> setuser(User user) => GetStorage().write('id', user);

  Future<String> getToken() async => GetStorage().read('token');
  Future<User?> getUser() async {
    final res = GetStorage().read('id');
    return res;
  }
}
