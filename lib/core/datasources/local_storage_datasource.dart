import 'package:get_storage/get_storage.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

class LocalStorageDataSource extends BaseDataSource {
  Future<void> setToken(String token) => GetStorage().write('token', token);
  Future<void> setuser(String id) => GetStorage().write('id', id);

  Future<String> getToken() async => GetStorage().read('token');
  Future<String?> getUser() async => GetStorage().read('id');
}
