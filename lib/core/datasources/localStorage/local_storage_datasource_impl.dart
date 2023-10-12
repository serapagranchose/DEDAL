import 'dart:convert';

import 'package:dedal/core/datasources/localStorage/local_storage_datasource.dart';
import 'package:dedal/core/dtos/sign_in_dto.dart';
import 'package:dedal/core/models/user.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _userBoxName = 'userBox';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  @override
  Future<SigninDto?> getCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';
    return SigninDto(email: email, password: password);
  }

  @override
  Future<void> setCredential(SigninDto info) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', info.email!);
    await prefs.setString('password', info.password!);
  }

  @override
  Future<User?> getUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    final user = box.get('user');
    print('get : $user');
    return user;
  }

  @override
  Future<void> saveUser(User user) async {
    print('save : $user');

    final box = await Hive.openBox<User>(_userBoxName);
    await box.put('user', user);
  }

  @override
  Future<void> clearUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    await box.delete('user');
  }
}
