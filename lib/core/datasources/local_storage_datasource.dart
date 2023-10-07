import 'package:dedal/core/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';

class LocalStorageDataSource extends BaseDataSource {
  Future<void> setuser(User user) {
    print(user);
    return GetStorage().write('id', user);
  }

  Future<User?> getUser() async {
    final res = GetStorage().read('id');
    return res;
  }
}
