import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:dedal/constants/enum/authentification_enum.dart';
import 'package:dedal/core/datasources/authentification/login_datasource.dart';
import 'package:dedal/core/models/user.dart';

class LoginDataSourceImplTest extends LoginDataSource {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    String? userToken;

    userToken = GetStorage().read('token');
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('http://52.166.128.133/ping'),
      );
      if (response.statusCode != 200) {
        yield AuthenticationStatus.apiOffline;
        yield* _controller.stream;
        return;
      }
    } catch (e) {
      yield AuthenticationStatus.apiOffline;
      yield* _controller.stream;
      return;
    }

    if (userToken == null) {
      yield AuthenticationStatus.unauthenticated;
      yield* _controller.stream;
      return;
    } else {
      response = await http.get(
        Uri.parse('https://app-api.mypet.fit/profile'),
        headers: {'Authorization': 'Bearer $userToken'},
      );

      if (response.statusCode != 200) {
        await GetStorage().remove('token');
        yield AuthenticationStatus.unauthenticated;
      } else {
        yield AuthenticationStatus.authenticated;
      }
    }

    yield* _controller.stream;
  }

  @override
  Future<User?> signIn(String email, String password) async =>
      email == 'test_email' && password == 'test_password'
          ? User.fromJson({'name': 'test_name'})
          : null;

  @override
  Future<bool> signUp(String email, String password) async =>
      email == 'test_email' && password == 'test_password' ? true : false;

  @override
  Future<bool> signUpCode(String email, String code) async =>
      email == 'test_email' && code == 'test_code' ? true : false;

  @override
  Future<bool> unsubscribe(String id, String email) async =>
      email == 'test_email' && id == 'test_id' ? true : false;
}
