import 'dart:convert';

import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/models/user.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _userBoxName = 'userBox';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  @override
  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = await prefs.getString('user') ?? '';
    print('get : $user');

    return User.fromJson(jsonDecode(user));
  }

  @override
  Future<void> saveUser(User user) async {
    print('save : $user');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', jsonEncode(user.toJson()));
    final box = await Hive.openBox<User>(_userBoxName);
    await box.put('user', user);
  }

  @override
  Future<void> clearUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    await box.delete('user');
  }
}
