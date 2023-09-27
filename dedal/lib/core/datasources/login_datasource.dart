import 'dart:convert';
import 'package:dedal/core/models/user.dart';
import 'package:wyatt_architecture/wyatt_architecture.dart';
import 'package:http/http.dart' as http;

class LoginDataSource extends BaseDataSource {
  Future<User?> signIn(String email, String password) async => await http.post(
        Uri.parse('http://52.166.128.133/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-type': 'application/json', 'Accept': '*/*'},
      ).then((result) {
        if (result.statusCode == 202) {
          final user = User.fromJson(jsonDecode(result.body));

          return user;
        }
        return null;
      });
}
